import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/rent_a_bus/widgets/vehicle_card_bus.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/appbar.dart';
import 'package:royal_falcon/view/rent_a_car/widgets/confirm_booking_bottom_sheet.dart';
import '../../view_model/bus_booking_view_model.dart';
import '../widgets/searchbar.dart';
import '../../../view_model/hourly_card_view_model.dart';

class BusBooking extends StatefulWidget {
  const BusBooking({super.key});

  @override
  State<BusBooking> createState() => _HourlyBookingState();
}

class _HourlyBookingState extends State<BusBooking> {
  bool isFullDaySelected = true;

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
                          'assets/images/bus_booking_cover.png'), // Ensure you have this image in your assets
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.zero, // Remove default padding
                  child: Column(
                    children: [
                      const AppbarHourly(title: 'Rent A Bus'),
                      SizedBox(
                          height: 100.h), // Adjust the height as per your design
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ElevatedSearchBar(
                          hintText: "Search",
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
                color: ColorConstants
                    .backgroundColor, // Background color for the remaining space
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20.0),
                        child: ChangeNotifierProvider(
                          create: (_) => BusCardViewModel(),
                          child: Consumer<VehicleCardViewModel>(
                            builder: (context, viewModel, child) {
                              return VehicleCardBus(
                                onBookNow: (price) {
                                  ConfirmBookingBottomSheet(
                                    vehicleName: 'King Long Bus',
                                    price: price,
                                  ).show(context);
                                },
                                showButton: true, // Show button in this context
                                price: viewModel.price, // Use dynamic price
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
