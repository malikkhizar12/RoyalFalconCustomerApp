import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/my_bookings/widgets/filter_dropdown.dart';
import 'package:royal_falcon/view_model/my_bookings_view_model.dart';
import 'package:royal_falcon/view/widgets/appbarcustom.dart';

import '../../model/my_bookings_model.dart';
import 'booking_details_view.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  String _selectedFilter = 'All'; // Track the selected filter

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyBookingsViewModel(),
      child: SafeArea(
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
                      SizedBox(height: 66.h),
                      Expanded(
                        child: Consumer<MyBookingsViewModel>(
                          builder: (context, viewModel, child) {
                            if (viewModel.isLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFFFBC07),
                                ),
                              );
                            } else if (viewModel.errorMessage != null) {
                              return Center(
                                child: Text('Error: ${viewModel.errorMessage}'),
                              );
                            } else if (viewModel.bookings.isEmpty) {
                              return Center(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),

                                height: 300,
                                  color: Color(0xFF595959),
                                  child: Center(child: Text('No bookings found',style: TextStyle(color: Colors.white),))));
                            } else {
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: viewModel.bookings.length,
                                      itemBuilder: (context, index) {
                                        Bookings booking = viewModel.bookings[index];
                                        Guest guest = booking.guests.first;

                                        return Card(
                                          color: Color(0xFF595959),
                                          margin: EdgeInsets.symmetric(vertical: 8.h),
                                          child: ListTile(
                                            leading: guest.vehicleCategoryId != null
                                                ? Image.network(
                                              guest.vehicleCategoryId!.categoryVehicleImage,
                                              width: 80.w,
                                              height: 90.h,
                                              fit: BoxFit.cover,
                                            )
                                                : Container(
                                              width: 80.w,
                                              height: 90.h,
                                              color: Colors.grey,
                                            ),
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  guest.vehicleCategoryId?.name ?? 'Unknown Vehicle',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '${guest.noOfBaggage} Baggage',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '${guest.noOfPeople} Persons',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  booking.status,
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BookingDetailsPage(booking: booking),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (viewModel.currentPage < viewModel.totalPages)
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await viewModel.fetchNextPage();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFFBC07),
                                        ),
                                        child: Text(
                                          'Next Page',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          },
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
    );
  }
}
