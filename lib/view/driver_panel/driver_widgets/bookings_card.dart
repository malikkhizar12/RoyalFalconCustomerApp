import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../model/driver_booking_model.dart';
import '../../my_bookings/booking_details_view.dart';
import '../home_screen/driver_booking_details.dart';

class BookingsCard extends StatelessWidget {
  final MyDriverBooking booking;

  final String pickUpLocation;
  final String dropOffLocation;
  final String pickUpDateTime;
  final String status;
  final String imageUrl;

  BookingsCard({
    required this.booking,
    required this.pickUpLocation,
    required this.dropOffLocation,
    required this.pickUpDateTime,
    required this.status,
    required this.imageUrl,
  });

  String truncateLocation(String location) {
    if (location.length > 26) {
      return location.substring(0, 26) + '...';
    } else {
      return location;
    }
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(dateTimeStr);
    return DateFormat("dd-MM-yyyy 'at' h:mma").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverBookingDetailsPage(booking: booking),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 30.r,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.5.sw, // Adjust width to prevent overflow
                      child: Text(
                        truncateLocation(pickUpLocation),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 0.5.sw, // Adjust width to prevent overflow
                      child: Text(
                        truncateLocation(dropOffLocation),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 0.5.sw, // Adjust width to prevent overflow
                      child: Text(
                        formatDateTime(pickUpDateTime),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
