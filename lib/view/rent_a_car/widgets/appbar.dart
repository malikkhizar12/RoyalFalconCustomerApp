import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarHourly extends StatelessWidget {
  final String title;

  const AppbarHourly({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.black.withOpacity(0.5), // Semi-transparent background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFFFBC07)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          SizedBox(width: 48), // To balance the space taken by the back button
        ],
      ),
    );
  }
}