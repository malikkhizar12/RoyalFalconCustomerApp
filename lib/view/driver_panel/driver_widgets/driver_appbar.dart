import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  AppBarCustom({required this.title, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF22272B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // authViewModel.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
