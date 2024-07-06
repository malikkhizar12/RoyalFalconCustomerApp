
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/Rides/Rides.dart';
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyBookingsViewModel(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Consumer<MyBookingsViewModel>(
            builder: (context, viewModel, child) {
              return RefreshIndicator(
                displacement: 40,
                color: Color(0xFFFFBC07),
                onRefresh: viewModel
                    .fetchUserBookings, // Trigger API call on pull-to-refresh
                child: Column(
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
                            Consumer<MyBookingsViewModel>(
                              builder: (context, viewModel, child) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 36.w),

                                    child: FilterDropdown(

                                      selectedFilter: viewModel.selectedFilter,
                                      onChanged: (newValue) {
                                        viewModel.setFilter(newValue!);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 66.h),
                            Expanded(
                              child: viewModel.isLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFFFBC07),
                                ),
                              )
                                  : viewModel.errorMessage != null
                                  ? Center(
                                child: Text(
                                    'Error: ${viewModel.errorMessage}'),
                              )
                                  : viewModel.filteredBookings.isEmpty
                                  ? Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w),
                                  height: 300.h,
                                  width: double.infinity,
                                  color: Color(0xFF595959),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No bookings Yet',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.sp,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                        textAlign:
                                        TextAlign.center,
                                      ),
                                      SizedBox(height: 20.h),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator
                                              .pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    Rides()),
                                          );
                                        },
                                        style: ElevatedButton
                                            .styleFrom(
                                          backgroundColor: Color(
                                              0xFFFFBC07), // Background color
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              20.w,
                                              vertical: 15.h),
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.r),
                                          ),
                                        ),
                                        child: Text(
                                          'Book your first ride',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : ListView.builder(
                                itemCount: viewModel
                                    .filteredBookings.length,
                                itemBuilder: (context, index) {
                                  Bookings booking = viewModel
                                      .filteredBookings[index];
                                  Guest guest =
                                      booking.guests.first;

                                  return Card(
                                    color: Color(0xFF595959),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.h),
                                    child: ListTile(
                                      leading:
                                      guest.vehicleCategoryId !=
                                          null
                                          ? Image.network(
                                        guest
                                            .vehicleCategoryId!
                                            .categoryVehicleImage,
                                        width: 80.w,
                                        height: 90.h,
                                        fit: BoxFit
                                            .cover,
                                      )
                                          : Container(
                                        width: 80.w,
                                        height: 90.h,
                                        color: Colors
                                            .white,
                                        child: Image.asset(
                                            'images/lexus300.png'),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            guest.vehicleCategoryId
                                                ?.name ??
                                                'Vehicle',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .end,
                                        children: [
                                          if (booking.status
                                              .toLowerCase() ==
                                              'payment pending')
                                            Text(
                                              'Pay Now >',
                                              style: TextStyle(
                                                color: Color(
                                                    0xFFFFBC07),
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            booking.status,
                                            style: TextStyle(
                                              color: booking
                                                  .status
                                                  .toLowerCase() ==
                                                  'pending'
                                                  ? Colors.orange
                                                  : Colors.green,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookingDetailsPage(
                                                    booking:
                                                    booking),
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
