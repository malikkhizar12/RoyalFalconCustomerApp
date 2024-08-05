import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/app_bar_widget.dart';

class PassportProSuccessView extends StatefulWidget {
  const PassportProSuccessView({super.key});

  @override
  State<PassportProSuccessView> createState() => _PassportProSuccessViewState();
}

class _PassportProSuccessViewState extends State<PassportProSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Success",backgroundColor: AppColors.backgroundColor,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Container(
            height: 1.sh,
            width: 1.sw,
            color: const Color(0xff333639),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                110.verticalSpace,
                Container(
                  height: 305.h,
                  width: 305.w,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/meeting_success_background.png"),
                    ),
                  ),
                  child: Container(
                    height: 117.h,
                    width: 117.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff4CD964),
                    ),
                    child: Icon(
                      Icons.done,
                      color: Color(0xff333639),
                      size: 60,
                    ),
                  ),
                ),
                40.verticalSpace,
                Text(
                  "Thank you for you trust!",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.kWhiteColor),
                ),
                Text(
                  "We will contact you in 1 Hour",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.kWhiteColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
