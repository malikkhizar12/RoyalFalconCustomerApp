import 'package:flutter/material.dart';

// Define an enum for booking types
enum BookingType { hourly, halfDay, fullDay }

class VehicleCardViewModel extends ChangeNotifier {
  int _hours;
  final int _pricePerHour;
  final int _initialPrice;
  final int _maxHours = 10;
  final BookingType? bookingType; // Nullable
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 3, minute: 0);

  // Constructor with booking type
  VehicleCardViewModel({
    this.bookingType,
    int initialPrice = 100,
    int pricePerHour = 25,
    int defaultHours = 1,
  })  : _initialPrice = initialPrice,
        _pricePerHour = pricePerHour,
        _hours = bookingType == BookingType.hourly ? defaultHours : 1;

  int get hours => _hours;

  int get price {
    switch (bookingType) {
      case BookingType.hourly:
        return _initialPrice + (_hours - 1) * _pricePerHour;
      case BookingType.halfDay:
      case BookingType.fullDay:
        return _initialPrice; // Fixed price for half-day and full-day
      default:
        return _initialPrice; // Default case if bookingType is null
    }
  }

  int get maxHours => _maxHours;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;

  void incrementHours() {
    if (bookingType == BookingType.hourly && _hours < _maxHours) {
      _hours++;
      notifyListeners();
    }
  }

  void decrementHours() {
    if (bookingType == BookingType.hourly && _hours > 1) {
      _hours--;
      notifyListeners();
    }
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setDefaultHours(int hours) {
    if (bookingType == BookingType.hourly) {
      _hours = hours;
      notifyListeners();
    }
  }

  // New method to get the selected hours as a formatted string
  int getSelectedHoursString() {
    return _hours;
  }
}
