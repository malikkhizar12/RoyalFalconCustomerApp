  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import '../model/my_bookings_model.dart';
  import '../model/user_model.dart';
  import '../resources/app_url.dart';
  import '../view_model/user_view_model.dart';

  class BookingRepository {
    final UserViewModel _userViewModel;

    BookingRepository(this._userViewModel);

    Future<List<Bookings>> getBookings(int page, int limit) async {
      try {
        final UserModel? user = await _userViewModel.getUser();
        if (user == null || user.token == null) {
          throw Exception('User token not found');
        }

        final response = await http.get(
          Uri.parse('${Appurl.getBooking}?page=$page&limit=$limit'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body)['bookings'];
          return jsonData.map((booking) => Bookings.fromJson(booking)).toList();
        } else {
          throw Exception('Failed to load bookings');
        }
      } catch (e) {
        throw Exception('Error fetching bookings: $e');
      }
    }
  }
