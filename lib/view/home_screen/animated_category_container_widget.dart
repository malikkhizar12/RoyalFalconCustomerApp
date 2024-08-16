import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedCategoryContainerWidget extends StatelessWidget {
  const AnimatedCategoryContainerWidget({
    super.key,
    required bool isVisible,
    required this.label,
    required this.image,
    required this.onTap,
  }) : isVisible = isVisible;

  final bool isVisible;
  final String label, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedScale(
        scale: isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1300),
        curve: Curves.easeInOut,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  height: 70.h,
                  width: 100.w, // Adjust width as needed
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      Image.asset(
                        height: 70.h,
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0.h),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
