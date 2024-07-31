import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            // const ElevatedSearchBar(hintText: "Type your country name",)
          ],
        ),
      ),
    );
  }
}
