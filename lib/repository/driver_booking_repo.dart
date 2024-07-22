import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/driver_booking_model.dart';
import '../model/user_model.dart';
import '../resources/app_url.dart';
import '../view_model/user_view_model.dart';

class DriverBookingRepository {
  final UserViewModel _userViewModel;

  DriverBookingRepository(this._userViewModel);

  Future<List<MyDriverBooking>> getDriverBookings(String driverId, int page, int limit) async {
    try {
      final UserModel? user = await _userViewModel.getUser();
      if (user == null || user.token == null) {
        throw Exception('User token not found');
      }

      final response = await http.get(
        Uri.parse('${Appurl.getDriverBooking}?driverId=$driverId&page=$page&limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${user.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['bookings'];
        return jsonData.map((booking) => MyDriverBooking.fromJson(booking)).toList();
      } else {
        throw Exception('Failed to load driver bookings');
      }
    } catch (e) {
      throw Exception('Error fetching driver bookings: $e');
    }
  }
}
