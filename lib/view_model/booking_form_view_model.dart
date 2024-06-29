import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingViewModel extends ChangeNotifier {
  // Fields
  String name = '';
  String email = '';
  bool isFromAirportBooking = false;
  int passengers = 0;
  int bags = 0;
  DateTime? pickupTime;
  String contactNumber = '';
  String pickupLocation = '';
  String dropoffLocation = '';
  String specialRequest = '';
  String flightNo = '';

  // Validators (add more as needed)
  String validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return '';
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    // Add more email validation logic if needed
    return '';
  }

  String validatePassengers(String value) {
    // Add validation logic for passengers
    return '';
  }

  // Method to handle date-time selection
  Future<void> selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: pickupTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // Allow selection for one year from now
      // Customize date picker colors
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07), // Customize primary color
              onPrimary: Colors.black, // Customize text color on primary color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickupTime ?? DateTime.now()),
        // Customize time picker colors
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: const Color(0xFFFFBC07), // Customize primary color
                onPrimary: Colors.black, // Customize text color on primary color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        pickupTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners(); // Notify listeners to update UI
      }
    }
  }

  // Method to reset form
  void resetForm() {
    name = '';
    email = '';
    isFromAirportBooking = false;
    passengers = 0;
    bags = 0;
    pickupTime = null;
    contactNumber = '';
    pickupLocation = '';
    dropoffLocation = '';
    specialRequest = '';
    flightNo = '';
    notifyListeners(); // Notify listeners to update UI
  }
}
