import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: selectedCountryCode,
                  items: <String>['+92', '+971', '+44'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCountryCode = newValue!;
                    });
                  },
                  underline: const SizedBox(),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value.length > 10) {
                        phoneNumberError = 'Phone number cannot exceed 10 digits';
                      } else {
                        phoneNumberError = null;
                      }
                    });
                  },
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
          ),
        ),
        if (phoneNumberError != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              phoneNumberError!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
