import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/search_bar_widget.dart';

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
      appBar: AppBar(
        title: Text(
          "Passport Pro",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            color: AppColors.kWhiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.kBlackColor,
        foregroundColor: AppColors.kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
            ),
          ),
        ],
      ),
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
                            child: Image.asset(
                              'images/passport.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "United Arab Emirates",
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
                                      color: AppColors.kStarColor,
                                    );
                                  },
                                  itemCount: 5,
                                ),
                              ),
                              Text(
                                "4.8 / 5",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kBlackColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "150 Reviews",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff8C8A93),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 30.h,
                      ),
                  itemCount: 5),
            ),
          ),
        ],
      ),
    );
  }
}
