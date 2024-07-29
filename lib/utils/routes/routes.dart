import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:royal_falcon/view/home_screen/homescreen.dart';
import 'package:royal_falcon/view/login/login.dart';
import 'package:royal_falcon/view/my_bookings/my_booking.dart';
import 'package:royal_falcon/view/rides/airport_bookings.dart';
import 'package:royal_falcon/view/rides/normal_bookings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../view/driver_panel/home_screen/driver_bookings_list.dart';
import '../../view/driver_panel/home_screen/driver_profile/driver_profile_screen.dart';
import '../../view/splash/splash_view.dart';

class Routes {
  static Future<Map<String, dynamic>> _getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      String role = userMap['role'];
      String userId = userMap['_id'] ?? '';
      return {
        'authenticated': true,
        'role': role,
        'userId': userId,
      };
    }
    return {
      'authenticated': false,
      'role': '',
      'userId': '',
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.login:
        return MaterialPageRoute(builder: (BuildContext context) => const Login());

      case RoutesNames.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesNames.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());

      case RoutesNames.normalBookings:
        return MaterialPageRoute(builder: (BuildContext context) => const NormalBookings());

      case RoutesNames.airportBookings:
        return MaterialPageRoute(builder: (BuildContext context) => AirportBookings());

      case RoutesNames.myBookings:
        return MaterialPageRoute(builder: (BuildContext context) => MyBookings());

      case RoutesNames.driverProfile:
        return MaterialPageRoute(builder: (BuildContext context) => DriverProfileScreen());

      case RoutesNames.driverHome:
        return MaterialPageRoute(
          builder: (BuildContext context) => FutureBuilder<Map<String, dynamic>>(
            future: _getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!['authenticated'] == true) {
                String role = snapshot.data!['role'];
                String userId = snapshot.data!['userId'] ?? '';
                if (role == 'driver') {
                  return DriverBookingPage(driverId: userId);
                } else {
                  return HomeScreen();
                }
              } else {
                return Login();
              }
            },
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text("No Route Defined", style: TextStyle(color: Colors.white)),
            ),
          );
        });
    }
  }
}
