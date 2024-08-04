import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final Color? fillColor; // Consistent variable naming convention
  final Color? textColor; // Consistent variable naming convention

  const ElevatedSearchBar(
      {Key? key,
      this.onChanged,
      this.textColor = Colors.white,
      this.hintText = 'Search Car',
      this.fillColor = Colors.white // Default hint text
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: TextField(
            cursorColor: Colors.white,
            textAlign: TextAlign.center, // Center the text and hint text
            style: TextStyle(
              color: textColor,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                  right: 18.w, // Adjusted padding on the right for the icon
                ),
                child: Image.asset(
                  'assets/images/search_icon.png',
                  height: 23.h,
                  width: 23.w,
                  color: textColor,
                ),
              ),
              hintText: hintText, // Corrected the variable name
              hintStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(42),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal:
                      20.w), // Increased horizontal padding for centering
            ),
          ),
        ),
      ),
    );
  }
}
