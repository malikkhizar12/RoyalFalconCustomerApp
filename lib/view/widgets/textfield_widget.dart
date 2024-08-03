import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E23),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.7),
        boxShadow: [
          BoxShadow(
            color: Color(0xff5E5B5B40).withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.5),
          //   spreadRadius: -5,
          //   blurRadius: 10,
          //   offset: const Offset(3, 3),
          // ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        ),
      ),
    );
  }
}
