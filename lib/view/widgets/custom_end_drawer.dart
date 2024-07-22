import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_model/auth_view_model.dart';
import '../driver_panel/home_screen/driver_profile/driver_profile_screen.dart';
import '../home_screen/profile.dart';

class CustomEndDrawer extends StatelessWidget {
  CustomEndDrawer({
    super.key,
  });
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

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0xFF3A3E41),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Image.asset('images/home_icon.png'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF333639),
              ),
              child: Column(
                children: [
                  FutureBuilder<Map<String, dynamic>>(
                    future: _getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        var userDetails = snapshot.data!;
                        return Column(
                          children: [
                            buildMenuItem('Profile', () {
                              if (userDetails['role'] == 'driver') {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverProfileScreen()));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                              }
                            }),
                            if (userDetails['role'] != 'driver')
                              buildMenuItem('My Booking', () {
                                Navigator.pushNamed(context, RoutesNames.myBookings);
                              }),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  buildMenuItem('Favorite', () {
                    // Handle Favorite action
                  }),
                  buildMenuItem('RFL wallet', () {
                    // Handle RFL wallet action
                  }),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF333639),
              ),
              child: Column(
                children: [
                  buildMenuItem('Region', () {
                    // Handle Region action
                  }),
                  buildMenuItem('Currency', () {
                    // Handle Currency action
                  }),
                  buildMenuItem('Language', () {
                    // Handle Language action
                  }),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFF333639),
              ),
              child: Column(
                children: [
                  buildMenuItem('Help & Support', () {
                    // Handle Help & Support action
                  }),
                  buildMenuItem('Terms & Conditions', () {
                    // Handle Terms & Conditions action
                  }),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color?>(const Color(0xFFFFBC07)),
                ),
                onPressed: () {
                  authViewModel.logout(context);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          Image.asset('images/nav_arrow_right.png'),
        ],
      ),
    );
  }
}
