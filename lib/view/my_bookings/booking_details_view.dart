import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:intl/intl.dart';

import '../../model/my_bookings_model.dart';
import '../widgets/appbarcustom.dart';
import '../../view_model/my_bookings_view_model.dart';

class BookingDetailsPage extends StatefulWidget {
  final Bookings booking;

  const BookingDetailsPage({Key? key, required this.booking}) : super(key: key);

  @override
  _BookingDetailsPageState createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startConditionalPolling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startConditionalPolling() {
    final viewModel = Provider.of<MyBookingsViewModel>(context, listen: false);
    viewModel.startConditionalPolling(widget.booking.id);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MyBookingsViewModel>(context);

    String formattedDate =
        DateFormat('MMMM d').format(widget.booking.guests.first.pickUpDateTime);
    String formattedTime =
        DateFormat('h:mm a').format(widget.booking.guests.first.pickUpDateTime);

    String flightNo = widget.booking.guests.first.flightNo ?? "None";
    String flightTiming = widget.booking.guests.first.flightTiming != null
        ? DateFormat('MMMM d, yyyy h:mm a')
            .format(DateTime.parse(widget.booking.guests.first.flightTiming!))
        : "None";

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 26.h),
          const AppbarCustom(title: 'Booking Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.booking.guests.first.vehicleCategoryId !=
                        null) ...[
                      Center(
                        child: Image.network(
                          widget.booking.guests.first.vehicleCategoryId!
                              .categoryVehicleImage,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        widget.booking.guests.first.vehicleCategoryId!.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                    Container(
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                        color: Color(0xFF595959),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pick-up Date & Time',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),
                          Text('Pick-up Date: $formattedDate',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          Text('Pick-up Time: $formattedTime',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          Text('Pick-up & Drop Off Location',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),
                          Text(
                              'Pick-up Location: ${widget.booking.guests.first.fromLocationName}',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          Text(
                              'Drop Off Location: ${widget.booking.guests.first.toLocationName}',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          Text('Baggage & People',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),
                          Text(
                              '${widget.booking.guests.first.noOfBaggage} Baggage',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          Text(
                              '${widget.booking.guests.first.noOfPeople} People',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          Text('Flight Number',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),
                          Text('Flight No: $flightNo',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          Text('Flight Timing',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),
                          Text('Flight Time: $flightTiming',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          Text('Assigned Driver & Vehicle Detail',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFBC07))),
                          SizedBox(height: 8.h),

                          Text('No Driver assigned yet',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(height: 16.h),
                          if (widget.booking.status.toLowerCase() ==
                              'payment pending')
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your payment logic here
                                  viewModel.makePayment(
                                      context,
                                      widget.booking.id,
                                      widget.booking.guests.first
                                          .vehicleCategoryId!.minimumAmount);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xFFFFBC07), // Background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 8.h),
                          Center(
                            child: Text(
                              widget.booking.status.toLowerCase() == 'pending'
                                  ? 'Waiting for Admin approval.'
                                  : 'Status: ${widget.booking.status}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: widget.booking.status.toLowerCase() ==
                                        'pending'
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
