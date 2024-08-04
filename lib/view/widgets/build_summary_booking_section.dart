import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';

class SummarySection extends StatelessWidget {
  final String distanceValue;
  final String possibleTime;
  final void Function()? onTap;
  final bool isLoading;
  final double price; // Assuming `price` is of type double

  const SummarySection({
    Key? key,
    required this.distanceValue,
    required this.possibleTime,
    required this.onTap,
    required this.isLoading,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Distance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  distanceValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Possible time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  possibleTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Cost",
              style: TextStyle(
                color: const Color(0xFFFFBC07),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$price AED",
              style: TextStyle(
                color: const Color(0xFFFFBC07),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 26.h),
        Center(
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFBC07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              minimumSize: Size(200.w, 50.h),
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 10.h,
              ),
            ),
            child: isLoading
                ? CircularProgressIndicator(
              color: AppColors.kWhiteColor,
            )
                : Text(
              'Book Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
