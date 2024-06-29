import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';

import '../widgets/appbarcustom.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  String _selectedFilter = 'All'; // Track the selected filter

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const AppbarCustom(title: 'My Bookings'),
            SizedBox(height: 60.h),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 60.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFBC07),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedFilter,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedFilter = newValue!;
                            });
                            // Perform actions based on the selected filter
                            // Example: filter list based on the selected filter
                          },
                          dropdownColor: Color(0xFFFFBC07),
                          icon: Icon(
                            Icons.arrow_drop_down, // Customize your icon here
                            color: Colors.white, // Change the icon color here
                          ),                          items: [
                            DropdownMenuItem<String>(
                              value: 'All',
                              child: Text(
                                'All',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Approved',
                              child: Text(
                                'Approved',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Disapproved',
                              child: Text(
                                'Disapproved',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Pending',
                              child: Text(
                                'Pending',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
