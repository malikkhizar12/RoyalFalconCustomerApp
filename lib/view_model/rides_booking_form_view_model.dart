import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:royal_falcon/utils/utils/utils.dart';

class RidesBookingFormViewModel extends ChangeNotifier {
  RidesBookingFormViewModel(this.context, this.amountToPay);

  BuildContext context;
  Map<String, dynamic>? paymentIntent;
  String possibleTime = "0", distanceInKm = "0";
  double amountToPay = 0.0;

  Future<void> makePayment() async {
    try {
      print(amountToPay);
      // Create payment intent data
      paymentIntent =
          await createPaymentIntent(amountToPay.toStringAsFixed(0), 'AED');
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          customerId: paymentIntent!['customer'],
          customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
          googlePay: const PaymentSheetGooglePay(
              currencyCode: "AED", merchantCountryCode: "AE"),
          // Merchant Name
          merchantDisplayName: 'RFL',
          // applePay: PaymentSheetApplePay(merchantCountryCode: "AE"),
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
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      // Displaying snackbar for it
      Utils.successMessage("Paid successfully", context);
      paymentIntent = null;
    } on StripeException catch (e) {
      // If any error comes during payment
      // so payment will be cancelled
      print('Error: $e');
      Utils.errorMessage("Payment Cancelled", context);
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency, int bookingId) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        'meta_data': {"booking_id": bookingId}
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
