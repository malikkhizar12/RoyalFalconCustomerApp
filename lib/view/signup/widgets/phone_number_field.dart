import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:royal_falcon/utils/colors.dart';

class SignupPhoneNumberField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isShadow;
  final Function(String)? onSubmitted;
  final Color backgroundColor;
  final double borderRadius;

  SignupPhoneNumberField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.isShadow = true,
    this.onSubmitted,
    this.backgroundColor = const Color(0xFF1A1E23),
    this.borderRadius = 10,
  });

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<SignupPhoneNumberField> {
  String selectedCountryCode = '+92';
  String? phoneNumberError;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor == Color(0xFF1A1E23)
            ? Color(0xFF1A1E23)
            : widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius.r),
        border: Border.all(color: Colors.black, width: 0.7),
        boxShadow: widget.isShadow
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          DropdownButton<String>(
            dropdownColor: widget.backgroundColor == Color(0xFF1A1E23)
                ? Color(0xFF1A1E23)
                : widget.backgroundColor,
            value: selectedCountryCode,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: widget.backgroundColor == Color(0xFF1A1E23)
                  ? AppColors.kWhiteColor.withOpacity(0.6)
                  : Color(0xFF1A1E23),
              size: 20,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            items: <String>['+92', '+971', '+44'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: widget.backgroundColor == Color(0xFF1A1E23)
                        ? AppColors.kWhiteColor.withOpacity(0.6)
                        : Color(0xFF1A1E23),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedCountryCode = newValue!;
              });
            },
            underline: const SizedBox(),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              cursorColor: AppColors.buttonColor,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: TextStyle(
                color: widget.backgroundColor == Color(0xFF1A1E23)
                    ? AppColors.kWhiteColor
                    : AppColors.kBlackColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle: TextStyle(
                  color: widget.backgroundColor == Color(0xFF1A1E23)
                      ? AppColors.kWhiteColor.withOpacity(0.6)
                      : Color(0xFF1A1E23),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onSubmitted: widget.onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
