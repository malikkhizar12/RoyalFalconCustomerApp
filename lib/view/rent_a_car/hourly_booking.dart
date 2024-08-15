import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/Rides/location_buttons.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/appbar.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/confirm_booking_bottom_sheet.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/full_day_bottom_sheet.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/half_day_bottom_sheet.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/vehicle_card_hourly.dart';
import '../widgets/searchbar.dart';
import '../../../view_model/hourly_card_view_model.dart';

class HourlyBooking extends StatefulWidget {
  const HourlyBooking({super.key});

  @override
  State<HourlyBooking> createState() => _HourlyBookingState();
}

class _HourlyBookingState extends State<HourlyBooking> {
  bool isFullDaySelected = false;
  bool isHalfDaySelected = false;

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
                      image: AssetImage(
                          'assets/images/hourly_booking_cover.png'), // Ensure you have this image in your assets
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.zero, // Remove default padding
                  child: Column(
                    children: [
                      const AppbarHourly(title: 'Rent A Car'),
                      SizedBox(
                          height: 100.h), // Adjust the height as per your design
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ElevatedSearchBar(
                          fillColor: Color(0xFFFFBC07),
                          textColor: Colors.white,
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
                color: AppColors.backgroundColor, // Background color for the remaining space
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        color: const Color(0xFF333639),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
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
                                    isHalfDaySelected = false;
                                  });
                                  ConfirmBookingFullDayBottomSheet(
                                    vehicles: [
                                      {'name': 'Sedan', 'price': 1000},
                                      {'name': 'SUV', 'price': 1500},
                                      {'name': 'Hi Roof', 'price': 1300},
                                      // Add more vehicles here
                                    ],
                                  ).show(context);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: LocationButton(
                                text: 'Half Day',
                                isSelected: isHalfDaySelected,
                                onTap: () {
                                  setState(() {
                                    isFullDaySelected = false;
                                    isHalfDaySelected = true;
                                  });
                                  ConfirmBookingHalfDayBottomSheet(
                                    vehicles: [
                                      {'name': 'Sedan', 'price': 500},
                                      {'name': 'SUV', 'price': 700},
                                      {'name': 'Hi Roof', 'price': 750},
                                      // Add more vehicles here
                                    ],
                                  ).show(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20.0),
                        child: ChangeNotifierProvider(
                          create: (_) => VehicleCardViewModel(
                            bookingType: BookingType.hourly, // Pass the bookingType here
                            initialPrice: 100,
                            pricePerHour: 25,
                          ),
                          child: Consumer<VehicleCardViewModel>(
                            builder: (context, viewModel, child) {
                              return VehicleCard(
                                onBookNow: (price) {
                                  ConfirmBookingBottomSheet(

                                    viewModel.hours, // Pass the selected hours here (change as needed)
                                    vehicleName: 'Sedan', // Pass the vehicle name
                                    price: price, // Pass the price
                                  ).show(context);
                                },
                                selectedHours: viewModel.getSelectedHoursString(),
                                showButton: true, // Show button in this context
                                price: viewModel.price,
                                vehicleName: 'Sedan', showPriceButton: true, // Use dynamic price
                              );
                            },
                          ),
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
