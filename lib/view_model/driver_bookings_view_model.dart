import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../model/driver_booking_model.dart';
import '../repository/driver_booking_repo.dart';
import '../view_model/user_view_model.dart';

class DriverBookingViewModel with ChangeNotifier {
  final DriverBookingRepository _repository = DriverBookingRepository(UserViewModel());
  Box? _driverBookingsBox;
  List<MyDriverBooking>? _driverBookings;
  List<MyDriverBooking>? _filteredBookings;

  List<MyDriverBooking>? get driverBookings => _filteredBookings;

  DriverBookingViewModel(String driverId) {
    _init(driverId);
  }

  Future<void> _init(String driverId) async {
    _driverBookingsBox = await Hive.openBox('driverBookings');
    await fetchDriverBookings(driverId);
  }

  Future<void> fetchDriverBookings(String driverId) async {
    try {
      List<MyDriverBooking> response = await _repository.getDriverBookings(driverId, 1, 10); // Default to page 1, limit 10
      print('Driver Booking ViewModel Response for $driverId: $response'); // Debug print
      _driverBookings = response;
      _filteredBookings = response;
      await _saveToHive();
      printBookings("All bookings:", _driverBookings);
      notifyListeners();
    } catch (e) {
      print('Error in DriverBookingViewModel: $e');
      throw e;
    }
  }

  Future<void> _saveToHive() async {
    if (_driverBookingsBox != null) {
      await _driverBookingsBox!.put('bookings', _driverBookings);
    }
  }

  Future<void> loadFromHive() async {
    if (_driverBookingsBox != null) {
      _driverBookings = _driverBookingsBox!.get('bookings')?.cast<MyDriverBooking>();
      _filteredBookings = _driverBookings;
      printBookings("Loaded from Hive:", _driverBookings);
      notifyListeners();
    }
  }

  void filterBookingsByDateTime(DateTime startDateTime, DateTime endDateTime, bool isDateChanged) {
    if (isDateChanged) {
      _filteredBookings = _driverBookings?.where((booking) {
        final bookingDateTime = DateTime.parse(booking.guests!.first.pickUpDateTime!);
        return bookingDateTime.isAfter(startDateTime) && bookingDateTime.isBefore(endDateTime);
      }).toList();
    } else {
      _filteredBookings = _driverBookings?.where((booking) {
        final bookingDateTime = DateTime.parse(booking.guests!.first.pickUpDateTime!);
        return bookingDateTime.hour >= startDateTime.hour &&
            bookingDateTime.hour <= endDateTime.hour &&
            bookingDateTime.minute >= startDateTime.minute &&
            bookingDateTime.minute <= endDateTime.minute;
      }).toList();
    }
    print('Filtering bookings from $startDateTime to $endDateTime');
    printBookings("Filtered bookings:", _filteredBookings);
    notifyListeners();
  }

  void clearFilters() {
    _filteredBookings = _driverBookings;
    notifyListeners();
  }

  void printBookings(String message, List<MyDriverBooking>? bookings) {
    print(message);
    if (bookings != null) {
      for (var booking in bookings) {
        final bookingDateTime = DateTime.parse(booking.guests!.first.pickUpDateTime!);
        print('Booking ID: ${booking.id}, Pickup DateTime: $bookingDateTime');
      }
    }
  }
}
