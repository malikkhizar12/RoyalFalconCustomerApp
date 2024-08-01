import 'package:flutter/material.dart';
import 'package:royal_falcon/view/login/login.dart';
import 'package:royal_falcon/view_model/splash_services/splash_services.dart';
import '../driver_panel/home_screen/driver_bookings_list.dart';
import '../home_screen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  Future<Map<String, dynamic>> checkAuth() async {
    return await splashServices.checkAuthentication();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: checkAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Image.asset('assets/images/splashIcon.png'),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!['authenticated'] == true) {
            String role = snapshot.data!['role'];
            String userId = snapshot.data!['userId'] ?? ''; // Ensure userId is not null
            if (role == 'driver') {
              return DriverBookingPage(driverId: userId); // Pass driverId to DriverBookingPage
            } else {
              return HomeScreen(); // Navigate to HomeScreen for other roles
            }
          } else {
            return Login(); // Navigate to Login if not authenticated
          }
        }
      },
    );
  }
}
