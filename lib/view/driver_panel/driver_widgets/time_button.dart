import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeButton extends StatelessWidget {
  final String time;
  final bool isSelected;

  TimeButton({required this.time, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: isSelected ? Color(0xFFFFBC07) : Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
