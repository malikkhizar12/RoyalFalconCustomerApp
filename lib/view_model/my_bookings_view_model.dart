import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:royal_falcon/view_model/user_view_model.dart';
import '../model/my_bookings_model.dart';
import '../model/user_model.dart';
import '../resources/app_url.dart';

class MyBookingsViewModel extends ChangeNotifier {
  List<Bookings> _bookings = [];
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, String> _statuses = {};
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetchingNextPage = false;

  List<Bookings> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isFetchingNextPage => _isFetchingNextPage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  MyBookingsViewModel() {
    fetchUserBookings(); // Fetch bookings initially
  }

  Future<void> fetchUserBookings() async {
    setLoading(true);
    _currentPage = 1;
    _bookings.clear();
    _totalPages = 1; // Reset total pages to ensure fresh fetch
    try {
      await _fetchAllBookings(replace: true); // Replace data on initial fetch
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> fetchNextPage() async {
    if (_currentPage >= _totalPages || _isFetchingNextPage) return;
    _isFetchingNextPage = true;
    try {
      _currentPage++;
      await _fetchAllBookings(replace: false); // Append data on next page fetch
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingNextPage = false;
      notifyListeners();
    }
  }

  Future<void> _fetchAllBookings({required bool replace}) async {
    final UserViewModel userViewModel = UserViewModel();
    UserModel? userModel = await userViewModel.getUser();
    if (userModel == null) {
      throw Exception('User not found or not logged in');
    }

    String token = userModel.token ?? '';
    if (token.isEmpty) {
      throw Exception('Token is empty or invalid');
    }

    print('Fetching page $_currentPage');
    final response = await http.get(
      Uri.parse('${Appurl.getBooking}?page=$_currentPage&limit=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List bookings = jsonResponse['bookings'];
      List<Bookings> newBookings = bookings.map((booking) => Bookings.fromJson(booking)).toList();

      if (replace) {
        _bookings = newBookings; // Replace the current data
      } else {
        _bookings.addAll(newBookings); // Append the new data
      }

      _bookings.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort by createdAt in descending order

      _totalPages = jsonResponse['pagination']['totalPages'];
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void startConditionalPolling(String bookingId) {
    Timer.periodic(Duration(seconds: 30), (timer) async {
      if (_statuses[bookingId] != 'pending') {
        timer.cancel();
        return;
      }
      await fetchUserBookings();
    });
  }

  String getStatus(String bookingId) {
    return _statuses[bookingId] ?? '';
  }
}
