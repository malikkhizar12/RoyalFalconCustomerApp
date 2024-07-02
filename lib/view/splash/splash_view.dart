import 'package:flutter/material.dart';
import 'package:royal_falcon/config/app_notification.dart';
import 'package:royal_falcon/view/login/login.dart';
import 'package:royal_falcon/view_model/splash_services/splash_services.dart';

import '../home_screen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  // AppNotifications appNotifications = AppNotifications();

  Future<bool> checkAuth() async {
    return await splashServices.checkAuthentication();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // appNotifications.requestNotificationsPermissions();
    // appNotifications.foregroundMessage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Image.asset('images/splashIcon.png'),
            ),
          );
        } else {
          if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return Login();
          }
        }
      },
    );
  }
}
