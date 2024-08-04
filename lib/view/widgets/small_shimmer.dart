import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class SmallShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: AppColors.backgroundColor, // Set the background color to black
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.2),
        highlightColor: Colors.grey
            .withOpacity(0.5), // Slightly lighter grey for highlight color
        child: Column(
          children: [
            // First rectangle
            Container(
              width: double.infinity,
              height: 210.0.h,
              color: Colors.grey[800],
            ),
          ],
        ),
      ),
    );
  }
}
