import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:royal_falcon/resources/app_url.dart';
import 'package:royal_falcon/utils/utils/utils.dart';
import 'package:royal_falcon/view_model/my_bookings_view_model.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';

import '../model/user_model.dart';
import '../view/my_bookings/my_booking.dart'; // Import the MyBookings page

class RidesBookingFormViewModel extends ChangeNotifier {
  RidesBookingFormViewModel(this.context, this.amountToPay);

  BuildContext context;
  Map<String, dynamic>? paymentIntent;
  String possibleTime = "0", distanceInKm = "0";
  double amountToPay = 0.0;
  bool isLoading = false;
  final UserViewModel userViewModel = UserViewModel();
  final MyBookingsViewModel myBookingsViewModel = MyBookingsViewModel();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> makePayment(String bookingId) async {
    try {
      print(amountToPay);
      paymentIntent = await createPaymentIntent(amountToPay.toStringAsFixed(0), 'AED', bookingId);
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
      displayPaymentSheet();
    } catch (e) {
      print("exception $e");
      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Utils.successMessage("Paid successfully", context);
      paymentIntent = null;
      // Navigate to MyBookings page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyBookings()),
            (Route<dynamic> route) => false,
      );
    } on StripeException catch (e) {
      print('Error: $e');
      Utils.errorMessage("Payment Cancelled", context);
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency, String bookingId) async {
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

  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData) async {
    try {
      setLoading(true);
      UserModel? userModel = await userViewModel.getUser();
      if (userModel == null) {
        throw Exception('User not found or not logged in');
      }

      String token = userModel.token ?? '';
      if (token.isEmpty) {
        throw Exception('Token is empty or invalid');
      }

      print('Token: $token');
      print('Booking Data: $bookingData');

      var response = await http.post(
        Uri.parse(Appurl.createBooking),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: jsonEncode(bookingData),
      );

      if (kDebugMode) {
        print('Request Body: ${jsonEncode(bookingData)}');
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Booking request sent successfully.');
        }
        Map<String, dynamic> bookingResponse = jsonDecode(response.body);
        String bookingId = bookingResponse['id']; // Assuming 'id' is the booking ID in the response
        await makePayment(bookingId);
        setLoading(false);

        myBookingsViewModel.fetchUserBookings();
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          setLoading(false);
          print('Error creating booking: HTTP ${response.statusCode}');
        }
        return {'status': 'error', 'message': 'HTTP ${response.statusCode}', 'response': response.body};
      }
    } catch (err) {
      if (kDebugMode) {
        print('Error creating booking: ${err.toString()}');
      }
      return {'status': 'error', 'message': err.toString()};
    }
  }

  Future<void> getTravelTime(double startLat, double startLng, double endLat, double endLng) async {
    final apiKey = dotenv.env['GOOGLE_API_KEY'];
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        final leg = data['routes'][0]['legs'][0];
        print(data['routes']);
        possibleTime = leg['duration']['text'].toString();
        distanceInKm = leg['distance']['text'].toString();
        if (kDebugMode) {
          print('Travel time: $possibleTime   distance $distanceInKm');
        }
        notifyListeners();
      } else {
        print('No route found');
      }
    } else {
      print('Failed to fetch directions');
    }
  }
}
