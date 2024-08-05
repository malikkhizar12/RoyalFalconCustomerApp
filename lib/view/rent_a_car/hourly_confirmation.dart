import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:royal_falcon/utils/colors.dart';

import '../rides/rides_widgets/form_text_field.dart';
import '../widgets/appbarcustom.dart';

class ConfirmationPage extends StatelessWidget {
  final String vehicleName;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int price;

  ConfirmationPage({
    required this.vehicleName,
    required this.selectedDate,
    required this.selectedTime,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final TextEditingController hourlyUserName =TextEditingController();
    final TextEditingController hourlyUserEmail =TextEditingController();
    final TextEditingController hourlyUserPhone =TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Column(
        children: [
          SizedBox(height: 20,),
          const AppbarCustom(title: "Confirmation"),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Vehicle: $vehicleName',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: $formattedDate', // Use the formatted date
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Time: ${selectedTime.format(context)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),
                Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                    child: FormTextField(
                      label: "Name",
                      hint: 'Your Name',
                      controller: hourlyUserName,
                    ),
                  ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: FormTextField(
                        label: "Phone Number",
                        hint: 'Enter your Phone NO',
                        controller: hourlyUserPhone,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 10.h,),
                Row(
                  children: [
                    Expanded(
                      child: FormTextField(
                        label: "Email",
                        hint: 'Enter Your Email',
                        controller: hourlyUserEmail,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFBC07),
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Your confirmation action here
                      },
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
