import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreenCategories extends StatelessWidget {
  final String? categoryTitle;
  final String? imagePath; // Path to the image to display
  final VoidCallback? onTap; // Action to perform when the widget is tapped

  const HomeScreenCategories({
    Key? key,
    this.categoryTitle,
    this.imagePath, // Pass the image path
    this.onTap, // Pass the navigation action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the provided tap action
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(imagePath!, width: 77.w, height: 67.h), // Use the provided image
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (categoryTitle == 'Hourly Hire') ...[
                Icon(
                  Icons.access_time, // Use an appropriate icon
                  color: Colors.red,
                  size: 16.0,
                ),
                SizedBox(width: 4.0),
              ],
              Text(
                categoryTitle!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}