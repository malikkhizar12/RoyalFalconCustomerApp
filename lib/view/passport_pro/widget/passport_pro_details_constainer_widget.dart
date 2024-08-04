import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';

class PassportProDetailsContainerWidget extends StatelessWidget {
  final String visaType, validityPeriod, lengthOfStay, amount;
  final VoidCallback onTap;
  const PassportProDetailsContainerWidget({
    super.key,
    required this.visaType,
    required this.validityPeriod,
    required this.lengthOfStay,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff4D4D4D),
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.table_view,
                    color: AppColors.kWhiteColor,
                    size: 20,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Visa type",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                ],
              ),
              Text(
                visaType,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.hourglass_empty_rounded,
                    color: AppColors.kWhiteColor,
                    size: 20,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Validity period",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: AppColors.kWhiteColor),
                  ),
                ],
              ),
              Text(
                validityPeriod,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.kWhiteColor,
                    size: 20,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Length of stay",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: AppColors.kWhiteColor),
                  ),
                ],
              ),
              Text(
                lengthOfStay,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ],
          ),
          80.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total amount",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              Text(
                "AED $amount/person",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
          30.verticalSpace,
          ButtonWidget(
            title: "Next",
            onTap: onTap,
            height: 48.h,
            width: 1.sw,
            buttonColor: AppColors.kPrimaryColor,
            borderRadius: 30,
          ),
        ],
      ),
    );
  }
}
