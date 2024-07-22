import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayButton extends StatelessWidget {
  final String day;
  final bool isSelected;

  DayButton({required this.day, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        day,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
