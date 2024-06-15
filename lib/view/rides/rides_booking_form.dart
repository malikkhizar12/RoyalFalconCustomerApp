import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appbarcustom.dart';

class RidesBookingForm extends StatelessWidget {
  const RidesBookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F23),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
        child: Column(
          children: [
            const AppbarCustom(title: "Booking"),
            SizedBox(height: 15.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: buildTextField(context, "No. of Pax:", "03 Adult / 01 Child")),
                        SizedBox(width: 8.w),
                        Expanded(child: buildTextField(context, "No. of Bags", "03")),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(child: buildTextField(context, "Pickup time:", "03 Adult / 01 Child")),
                        SizedBox(width: 8.w),
                        Expanded(child: buildTextField(context, "Pickup location :", "03")),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(child: buildTextField(context, "Flight no:", "03 Adult / 01 Child")),
                        SizedBox(width: 8.w),
                        Expanded(child: buildTextField(context, "Drop off location:", "03")),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(child: buildTextField(context, "Special Request :", "03 Adult / 01 Child")),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      padding: EdgeInsets.all(16.h),
                      margin: EdgeInsets.only(top: 16.h),
                      decoration: const BoxDecoration(
                        color: Color(0xFF333639),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: buildSummarySection(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFBC07)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSummarySection(BuildContext context) {
    return Column(
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
          "26.7km",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Possible time",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "10 minutes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 26.h),
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
              "100 AED",
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
            onPressed: () {
              // Add your payment action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFBC07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 10.h,
              ),
            ),
            child: Text(
              'Pay Now',
              style: TextStyle(
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

