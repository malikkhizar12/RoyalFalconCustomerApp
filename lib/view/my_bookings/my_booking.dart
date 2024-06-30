import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/my_bookings/widgets/filter_dropdown.dart';

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
                    FilterDropdown(
                      selectedFilter: _selectedFilter,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedFilter = newValue!;
                        });
                        // Perform actions based on the selected filter
                        // Example: filter list based on the selected filter
                      },
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
