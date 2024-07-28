import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/Rides/location_buttons.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/appbar.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/confirm_booking_bottom_sheet.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/vehicle_card_hourly.dart';
import '../widgets/searchbar.dart';

class HourlyBooking extends StatefulWidget {
  const HourlyBooking({super.key});

  @override
  State<HourlyBooking> createState() => _HourlyBookingState();
}

class _HourlyBookingState extends State<HourlyBooking> {
  bool isFullDaySelected = true;
  ConfirmBookingBottomSheet confirmBookingBottomSheet=ConfirmBookingBottomSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 0.28.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/hourly_booking_cover.png'), // Ensure you have this image in your assets
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.zero, // Remove default padding
                  child: Column(
                    children: [
                      const AppbarHourly(title: 'Rent A Car'),
                      SizedBox(height: 100.h), // Adjust the height as per your design
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedSearchBar(
                          fillcolor: Color(0xFFFFBC07),
                          textcolor: Colors.white,
                        ),
                      ),
                      // Add other widgets here if needed
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: 1.sw,
                color: ColorConstants.backgroundColor, // Background color for the remaining space
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      Container(
                        color: const Color(0xFF333639),
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: LocationButton(
                                text: 'Full Day',
                                isSelected: isFullDaySelected,
                                onTap: () {
                                  setState(() {
                                    isFullDaySelected = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Expanded(
                              child: LocationButton(
                                text: 'Half Day',
                                isSelected: !isFullDaySelected,
                                onTap: () {
                                  setState(() {
                                    isFullDaySelected = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                        child: VehicleCard(
                          onBookNow: () {
                            confirmBookingBottomSheet.show(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
