import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:royal_falcon/utils/utils/utils.dart';
import 'package:royal_falcon/view/my_bookings/my_booking.dart';
import 'dart:convert';
import 'package:royal_falcon/view_model/user_view_model.dart';
import '../model/my_bookings_model.dart';
import '../model/user_model.dart';
import '../resources/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingsViewModel extends ChangeNotifier {
  List<Bookings> _bookings = [];
  List<Bookings> filteredBookings = [];
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, String> _statuses = {};
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetchingNextPage = false;
  String _selectedFilter = 'All';
  Map<String, dynamic>? paymentIntent;

  List<Bookings> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isFetchingNextPage => _isFetchingNextPage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  String get selectedFilter => _selectedFilter;

  MyBookingsViewModel() {
    fetchUserBookings(); // Fetch bookings initially
  }

  Future<void> fetchUserBookings() async {
    setLoading(true);
    _currentPage = 1;
    _bookings.clear();
    _totalPages = 1; // Reset total pages to ensure fresh fetch
    try {
      await _fetchAllBookings(replace: true); // Replace data on initial fetch
      filterBookings(_selectedFilter); // Initialize filtered bookings
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void setFilter(String status) {
    _selectedFilter = status;
    filterBookings(status);
  }

  void filterBookings(String status) {
    print('Filtering bookings with status: $status');
    if (status == 'All') {
      filteredBookings =
          List.from(_bookings); // Copy list to avoid direct reference
    } else {
      filteredBookings = _bookings
          .where(
              (booking) => booking.status.toLowerCase() == status.toLowerCase())
          .toList();
    }
    print('Filtered bookings count: ${filteredBookings.length}');
    notifyListeners(); // Notify listeners of the state change
  }

  Future<void> fetchNextPage() async {
    if (_currentPage >= _totalPages || _isFetchingNextPage) return;
    _isFetchingNextPage = true;
    try {
      _currentPage++;
      await _fetchAllBookings(replace: false); // Append data on next page fetch
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingNextPage = false;
      notifyListeners();
    }
  }

  Future<void> _fetchAllBookings({required bool replace}) async {
    final UserViewModel userViewModel = UserViewModel();
    UserModel? userModel = await userViewModel.getUser();
    if (userModel == null) {
      throw Exception('User not found or not logged in');
    }

    String token = userModel.token ?? '';
    if (token.isEmpty) {
      throw Exception('Token is empty or invalid');
    }

    print('Fetching page $_currentPage');
    final response = await http.get(
      Uri.parse('${Appurl.getBooking}?page=$_currentPage&limit=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List bookings = jsonResponse['bookings'];
      List<Bookings> newBookings =
          bookings.map((booking) => Bookings.fromJson(booking)).toList();

      if (replace) {
        _bookings = newBookings; // Replace the current data
      } else {
        _bookings.addAll(newBookings); // Append the new data
      }

      _bookings.sort((a, b) => b.createdAt
          .compareTo(a.createdAt)); // Sort by createdAt in descending order

      _totalPages = jsonResponse['pagination']['totalPages'];
      filterBookings(
          _selectedFilter); // Update filtered bookings after fetching

      // Cache the bookings data locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cachedBookings', json.encode(_bookings));
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void startConditionalPolling(String bookingId) {
    Timer.periodic(Duration(seconds: 30), (timer) async {
      if (_statuses[bookingId] != 'pending') {
        timer.cancel();
        return;
      }
      await fetchUserBookings();
    });
  }

  String getStatus(String bookingId) {
    return _statuses[bookingId] ?? '';
  }

  Future<void> makePayment(
      BuildContext context, String bookingId, amountToPay) async {
    try {
      // print(amountToPay);
      paymentIntent = await createPaymentIntent(
          amountToPay.toStringAsFixed(0), 'AED', bookingId);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          customerId: paymentIntent!['customer'],
          customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
          googlePay: const PaymentSheetGooglePay(
            currencyCode: "AED",
            merchantCountryCode: "AE",
          ),
          merchantDisplayName: 'RFL',
        ),
      );
      displayPaymentSheet(context);
    } catch (e) {
      print("exception $e");
      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Utils.successMessage("Paid successfully", context);
      paymentIntent = null;
      // Navigate to MyBookings page
      Navigator.pop(context);
    } on StripeException catch (e) {
      print('Error: $e');
      Utils.errorMessage("Payment Cancelled", context);
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency, String bookingId) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        'metadata[booking_id]': bookingId
      };
      print(body);
      var secretKey = dotenv.env['STRIPE_SECRET_KEY'];
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      throw Exception('Failed to create payment intent');
    }
  }
}
