import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'bookings_card.dart';
import '../../../model/driver_booking_model.dart';

class BookingsList extends StatelessWidget {
  final List<MyDriverBooking> bookings;

  BookingsList({required this.bookings});

  List<MyDriverBooking> getSortedBookings() {
    bookings.sort((a, b) {
      DateTime dateA = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(a.guests!.first.pickUpDateTime!);
      DateTime dateB = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(b.guests!.first.pickUpDateTime!);
      return dateA.compareTo(dateB);
    });
    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    List<MyDriverBooking> sortedBookings = getSortedBookings();

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: sortedBookings.length,
      itemBuilder: (context, index) {
        final booking = sortedBookings[index];
        final guest = booking.guests!.first;

        return BookingsCard(
          booking: booking,
          pickUpLocation: guest.fromLocationName ?? 'Unknown',
          dropOffLocation: guest.toLocationName ?? 'Unknown',
          pickUpDateTime: guest.pickUpDateTime ?? 'Unknown',
          status: booking.status ?? 'Unknown',
          imageUrl: 'https://via.placeholder.com/150',  // Replace with actual image URL if available
        );
      },
    );
  }
}
