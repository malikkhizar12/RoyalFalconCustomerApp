import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:royal_falcon/utils/colors.dart';

class SignupPhoneNumberField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  SignupPhoneNumberField({required this.label, required this.controller});

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
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          DropdownButton<String>(
            dropdownColor: AppColors.backgroundColor,
            value: selectedCountryCode,
            borderRadius: BorderRadius.circular(13.r),
            items: <String>['+92', '+971', '+44'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
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
              keyboardType: TextInputType.phone,
              cursorColor: AppColors.buttonColor,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
