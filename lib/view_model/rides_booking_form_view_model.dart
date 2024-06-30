import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:royal_falcon/resources/app_url.dart';
import 'package:royal_falcon/utils/utils/utils.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart'; // Add this import

class RidesBookingFormViewModel extends ChangeNotifier {

  RidesBookingFormViewModel(this.context, this.amountToPay);

  BuildContext context;
  Map<String, dynamic>? paymentIntent;
  String possibleTime = "0", distanceInKm = "0";
  double amountToPay = 0.0;
  final UserViewModel userViewModel=UserViewModel();
  Future<void> bookRideAndMakePayment(Map<String, dynamic> bookingData) async {
    try {
      // Call the booking API
      var bookingResponse = await createBooking(bookingData);
      if (bookingResponse['status'] == 'Booking created successfully') {
        // If booking is successful, proceed with payment
        await makePayment();
      } else {
        // Handle booking failure
        Utils.errorMessage("Booking Failed", context);
      }
    } catch (e) {
      print("exception $e");
      Utils.errorMessage("An error occurred", context);
    }
  }

  Future<void> makePayment() async {
    try {
      print(amountToPay);
      // Create payment intent data
      paymentIntent = await createPaymentIntent(amountToPay.toStringAsFixed(0), 'AED');
      // Initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          customerId: paymentIntent!['customer'],
          customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
          googlePay: const PaymentSheetGooglePay(
              currencyCode: "AED",
              merchantCountryCode: "AE"
          ),
          merchantDisplayName: 'RFL',
        ),
      );
      // Display payment sheet
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

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Utils.successMessage("Paid successfully", context);
      paymentIntent = null;
    } on StripeException catch (e) {
      print('Error: $e');
      Utils.errorMessage("Payment Cancelled", context);
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var secretKey = dotenv.env['STRIPE_SECRET_KEY'];
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
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

      print('Request Body: ${jsonEncode(bookingData)}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        print('Booking request sent successfully.');
        makePayment();
        return jsonDecode(response.body);
      } else {
        print('Error creating booking: HTTP ${response.statusCode}');
        return {'status': 'error', 'message': 'HTTP ${response.statusCode}', 'response': response.body};
      }
    } catch (err) {
      print('Error creating booking: ${err.toString()}');
      return {'status': 'error', 'message': err.toString()};
    }
  }
  Future<void> getTravelTime(
      double startLat, double startLng, double endLat, double endLng) async {
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
        print('Travel time: $possibleTime   distance $distanceInKm');
        notifyListeners();
      } else {
        print('No route found');
      }
    } else {
      print('Failed to fetch directions');
    }
  }
}
