import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:royal_falcon/utils/colors.dart';
import '../../../model/driver_booking_model.dart';
import '../../widgets/appbarcustom.dart';
import '../driver_widgets/driver_appbar.dart';

class DriverBookingDetailsPage extends StatefulWidget {
  final MyDriverBooking booking;

  DriverBookingDetailsPage({required this.booking});

  @override

  _DriverBookingDetailsPageState createState() => _DriverBookingDetailsPageState();
}

class _DriverBookingDetailsPageState extends State<DriverBookingDetailsPage> {
  bool isBookingStarted = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(dateTimeStr);
    return DateFormat("dd-MM-yyyy 'at' h:mma").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final guest = widget.booking.guests!.first;

    String formattedDate = DateFormat('MMMM d').format(DateTime.parse(guest.pickUpDateTime!));
    String formattedTime = DateFormat('h:mm a').format(DateTime.parse(guest.pickUpDateTime!));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            AppBarCustom(title: 'Booking Details', scaffoldKey: _scaffoldKey,),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
              child: Container(
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Color(0xFF595959),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Guest Name',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('${guest.name ?? 'Unknown'}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 8.h),
                    Text('Contact Number',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('${guest.contactNumber ?? 'Unknown'}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 16.h),
                    Text('Pick-up Date & Time',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('Pick-up Date: $formattedDate',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    Text('Pick-up Time: $formattedTime',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 16.h),
                    Text('Pick-up Location',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('${guest.fromLocationName ?? 'Unknown'}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 8.h),
                    Text('Drop Off Location',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('${guest.toLocationName ?? 'Unknown'}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 16.h),
                    Text('Baggage & People',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text('${guest.noOfpeople} Person',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    Text('${guest.noOfBaggage} Baggage',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 16.h),
                    Text('Special Request',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFBC07))),
                    SizedBox(height: 8.h),
                    Text(guest.specialRequest ?? 'None',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                    SizedBox(height: 16.h),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isBookingStarted = !isBookingStarted;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isBookingStarted ? Colors.red : Color(0xFFFFBC07),
                            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            isBookingStarted ? 'End Booking' : 'Start Booking',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    )
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
