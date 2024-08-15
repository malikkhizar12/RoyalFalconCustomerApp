import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/view/partner_up/widgets/partner_up_form.dart';
import 'package:royal_falcon/view/widgets/appbarcustom.dart';

class PartnerUpDetails extends StatelessWidget {
  final String title;
  final String description;

  PartnerUpDetails({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),

            AppbarCustom(title: "Partner UP"),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start Earning With Royal Falcon Limousine!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Be Our Corporate Vendor",
                    style: TextStyle(
                      color: Color(0xFFFFBC07),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCard(
                          context,
                          "assets/images/business_image.jpg", // Replace with the correct path
                          "Business Meeting",
                          "Lorem ipsum dolor sit amet consectetur. Eget nunc facilisis a quis. Quam nam natoque mus orci. Ut arcu quis mauris tortor aliquam semper euismod. Nec egestas vitae urna quis id lacus.",
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _buildCard(
                          context,
                          "assets/images/transportation.jpg", // Replace with the correct path
                          "Transportation Service",
                          "Lorem ipsum dolor sit amet consectetur. Eget nunc facilisis a quis. Quam nam natoque mus orci. Ut arcu quis mauris tortor aliquam semper euismod. Nec egestas vitae urna quis id lacus.",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Color(0xFF333639),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Contact us for more details.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFBC07),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PartnerUpFormView(

                                ),
                              ),
                            );

                          },
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String title, String description) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Color(0xFF333639),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFFFBC07),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
