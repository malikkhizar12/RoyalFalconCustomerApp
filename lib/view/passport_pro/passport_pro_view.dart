import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/passport_pro/passport_details.dart';
import 'package:royal_falcon/view/passport_pro/widget/passport_pro_main_container_widget.dart';
import 'package:royal_falcon/view/widgets/app_bar_widget.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
import 'package:royal_falcon/view/widgets/searchbar.dart';

class PassportProView extends StatefulWidget {
  const PassportProView({super.key});

  @override
  State<PassportProView> createState() => _PassportProViewState();
}

class _PassportProViewState extends State<PassportProView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlackColor,
      appBar: AppBarWidget(title: "Passport Pro",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.only(
                left: 25.w, right: 25.w, top: 40.h, bottom: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedSearchBar(
                  fillColor: AppColors.kPrimaryColor,
                  hintText: "Search",
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Explore Visas",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Royal Falcon Limousine",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                    color: Color(0xffCCCCCC),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 1.sw,
              color: AppColors.kDarkGrayColor,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 30.h,
              ),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PassportDetailsView(),),);
                    },
                    child: PassportProMainContainerWidget(
                      numberOfVisa: "10k+ visa on R.Falcon",
                      countryName: "United Arab Emirates",
                      reviews: '140',
                      amount: '400',
                      ratings: 3,
                      image: 'assets/images/passport.png',
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 30.h,
                ),
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

