import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField(String label, TextEditingController controller, TextInputType keyboardType, {bool obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
      SizedBox(height: 5.h),
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1E23),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -5,
              blurRadius: 10,
              offset: const Offset(-3, -3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          ),
        ),
      ),
    ],
  );
}
