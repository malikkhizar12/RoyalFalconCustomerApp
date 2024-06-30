import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/routes/routes_names.dart';

import '../../view_model/auth_view_model.dart';
import '../home_screen/profile.dart';

class CustomEndDrawer extends StatelessWidget {
  CustomEndDrawer({
    super.key,
  });

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
                  buildMenuItem('Profile', () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ProfileScreen()));
                  }),
                  buildMenuItem('My Booking', () {
                    Navigator.pushNamed(context, RoutesNames.myBookings);
                  }),
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
                  backgroundColor: MaterialStateProperty.all<Color?>(const Color(0xFFFFBC07)),
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
