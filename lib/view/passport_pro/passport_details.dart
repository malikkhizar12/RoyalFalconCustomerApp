import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/passport_pro/passport_meeting_form_view.dart';
import 'package:royal_falcon/view/passport_pro/widget/passport_pro_details_constainer_widget.dart';
import 'package:royal_falcon/view/widgets/app_bar_widget.dart';

class PassportDetailsView extends StatefulWidget {
  const PassportDetailsView({super.key});

  @override
  State<PassportDetailsView> createState() => _PassportDetailsViewState();
}

class _PassportDetailsViewState extends State<PassportDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "United Arab Emirates",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              20.verticalSpace,
              Container(
                width: 1.sw,
                height: 340.h,
                child: Image.asset(
                  "images/passport.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 52.h,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Color(0xffF8F8FF),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: Text(
                    "United Arab Emirates",
                    style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              15.verticalSpace,
              PassportProDetailsContainerWidget(
                visaType: 'Tourist',
                validityPeriod: '60 days',
                lengthOfStay: '30 days',
                amount: '600',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassportMeetingFormView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
