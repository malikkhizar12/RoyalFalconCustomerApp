import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(16.0.w),
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.2),
        highlightColor: Colors.grey,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.0.h),
                  // First rectangle
                  Container(
                    width: double.infinity,
                    height: 80.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Smaller rectangles
                  Container(
                    width: double.infinity,
                    height: 20.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Second rectangle
                  Container(
                    width: double.infinity,
                    height: 20.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Smaller rectangle at the bottom
                  Container(
                    width: double.infinity,
                    height: 40.0.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.0.h),
                  // First rectangle
                  Container(
                    width: double.infinity,
                    height: 80.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Smaller rectangles
                  Container(
                    width: double.infinity,
                    height: 20.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Second rectangle
                  Container(
                    width: double.infinity,
                    height: 20.0.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.0.h),
                  // Smaller rectangle at the bottom
                  Container(
                    width: double.infinity,
                    height: 40.0.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
