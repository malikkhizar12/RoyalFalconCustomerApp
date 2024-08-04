import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';

class PassportProMainContainerWidget extends StatelessWidget {
  final String numberOfVisa, countryName, reviews, amount, image;
  final int ratings;
  const PassportProMainContainerWidget({
    super.key,
    required this.numberOfVisa,
    required this.countryName,
    required this.reviews,
    required this.amount,
    required this.ratings,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: Container(
                    height: 25.h,
                    width: 125.w,
                    decoration: BoxDecoration(
                        color: Color(0xffE7E6E6).withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        )),
                    padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          numberOfVisa,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.kBlackColor,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            countryName,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.kBlackColor,
            ),
          ),
          Row(
            children: [
              Container(
                width: 140.w,
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star_rounded,
                      color: ratings <= index
                          ? AppColors.cardBackground
                          : AppColors.kStarColor,
                    );
                  },
                  itemCount: 5,
                ),
              ),
              Text(
                "${ratings.toString()} / 5",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kBlackColor,
                ),
              ),
            ],
          ),
          Text(
            "$reviews Reviews",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff8C8A93),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 32.h,
              width: 135.w,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                    color: AppColors.kBlackColor.withOpacity(0.1),
                  ),
                  BoxShadow(
                    blurRadius: 8.0,
                    spreadRadius: 0,
                    offset: Offset(0, 8),
                    color: AppColors.kBlackColor.withOpacity(0.09),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "AED $amount",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
