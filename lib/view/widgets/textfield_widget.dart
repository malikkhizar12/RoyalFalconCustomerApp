import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText, isPassword, isShadow;
  final VoidCallback? iconOnTap;
  final Function(String)? onSubmitted;
  final Color backgroundColor;
  final double borderRadius;
  final int minLines, maxLines;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.isPassword = false,
    this.iconOnTap,
    this.onSubmitted,
    this.isShadow = true,
    this.backgroundColor = const Color(0xFF1A1E23),
    this.borderRadius = 10,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor == Color(0xFF1A1E23)
            ? Color(0xFF1A1E23)
            : backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(color: Colors.black, width: 0.7),
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: Color(0xff5E5B5B40).withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ]
            : [],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: AppColors.buttonColor,
        minLines: minLines,
        maxLines: maxLines,
        style: TextStyle(
          color: backgroundColor == Color(0xFF1A1E23)
              ? AppColors.kWhiteColor
              : AppColors.kBlackColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: backgroundColor == Color(0xFF1A1E23)
                ? AppColors.kWhiteColor.withOpacity(0.6)
                : Color(0xFF1A1E23),
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: iconOnTap,
                  icon: Icon(
                    obscureText == false
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.buttonColor,
                  ),
                )
              : SizedBox(),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
