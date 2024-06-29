import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:royal_falcon/utils/utils/utils.dart';

class RidesBookingFormViewModel extends ChangeNotifier {
  RidesBookingFormViewModel(this.context);

  BuildContext context;
  Map<String, dynamic>? paymentIntent;
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  // TextEditingController _controller = TextEditingController();
  // String _selectedLocation = "";
  //
  // Future<void> _handlePressButton() async {
  //   String kGoogleApiKey = dotenv.env['GOOGLE_API_KEY']!;
  //   Prediction p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: kGoogleApiKey,
  //     mode: Mode.overlay, // Mode.fullscreen
  //     language: "en",
  //     components: [Component(Component.country, "us")],
  //   );
  //
  //   if (p != null) {
  //     PlacesDetailsResponse detail =
  //         await _places.getDetailsByPlaceId(p.placeId);
  //     _selectedLocation = p.description;
  //     _controller.text = p.description
  //     notifyListeners();
  //   }
  // }

  Future<void> makePayment() async {
    try {
      // Create payment intent data
      paymentIntent = await createPaymentIntent('100', 'AED');
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
      Utils.errorMessage("Payment Cancelled" as ScaffoldMessengerState, context);
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
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
}
