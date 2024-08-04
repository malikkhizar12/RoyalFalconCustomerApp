import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:royal_falcon/utils/utils/utils.dart';
import 'package:royal_falcon/view/my_bookings/my_booking.dart';
import 'package:http/http.dart' as http;

class StripePayment {
  Future<void> makePayment(BuildContext context, String bookingId,
      Map<String, dynamic> paymentIntent, int amountToPay) async {
    try {
      print(amountToPay);
      paymentIntent = await createPaymentIntent(
          amountToPay.toStringAsFixed(0), 'AED', bookingId);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          customerId: paymentIntent['customer'],
          customerEphemeralKeySecret: paymentIntent['ephemeralKey'],
          googlePay: const PaymentSheetGooglePay(
            currencyCode: "AED",
            merchantCountryCode: "AE",
          ),
          merchantDisplayName: 'RFL',
        ),
      );
      displayPaymentSheet(context, paymentIntent);
    } catch (e) {
      print("exception $e");
      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  Future<void> displayPaymentSheet(BuildContext context, paymentIntent) async {
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
