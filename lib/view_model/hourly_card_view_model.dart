import 'package:flutter/material.dart';

class VehicleCardViewModel extends ChangeNotifier {
  int _hours = 1;
  final int _pricePerHour;
  final int _initialPrice;
  final int _maxHours = 10;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 3, minute: 0);

  VehicleCardViewModel({int initialPrice = 100, int pricePerHour = 25})
      : _initialPrice = initialPrice,
        _pricePerHour = pricePerHour;

  int get hours => _hours;
  int get price => _initialPrice + (_hours - 1) * _pricePerHour; // Initial price + extra hours * price per hour
  int get maxHours => _maxHours;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;

  void incrementHours() {
    if (_hours < _maxHours) {
      _hours++;
      notifyListeners();
    }
  }

  void decrementHours() {
    if (_hours > 1) {
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
}
