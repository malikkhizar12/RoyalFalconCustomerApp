import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rides/rides_main_dubai_card.dart';
import 'package:royal_falcon/view/rides/rides_on_selected_location.dart';

import '../../utils/colors.dart';
import '../../view_model/vehicle_view_model.dart';
import '../widgets/appbarcustom.dart';
import '../widgets/shimmer_effect.dart';
import 'location_buttons.dart';

class NormalBookings extends StatefulWidget {
  const NormalBookings({super.key});

  @override
  State<NormalBookings> createState() => _NormalBookingsState();
}

class _NormalBookingsState extends State<NormalBookings> {
  String selectedLocation = 'Dubai';
  String? pickupLocation;
  String? dropoffLocation;

  void _checkLocationsAndNavigate() {
    if (pickupLocation != null && dropoffLocation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const YourRides()),
      );
    }
  }

  void _onLocationChanged(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarCustom(title: 'Normal Bookings'),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFF333639),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LocationButton(
                              text: 'Dubai',
                              isSelected: selectedLocation == 'Dubai',
                              onTap: () {
                                _onLocationChanged('Dubai');
                              },
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: LocationButton(
                              text: 'Abu Dhabi',
                              isSelected: selectedLocation == 'Abu Dhabi',
                              onTap: () {
                                _onLocationChanged('Abu Dhabi');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Consumer<VehicleViewModel>(
                      builder: (context, vehicleViewModel, child) {
                        if (vehicleViewModel.loading) {
                          return CustomShimmerLoading();
                        } else {
                          var vehicles = vehicleViewModel.getVehiclesByLocation(selectedLocation);
                          if (vehicles.isEmpty) {
                            return Center(child: Text('No Vehicle for this Location', style: TextStyle(color: Colors.white)));
                          } else {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: width > 392
                                    ? 0.60
                                    : (width > 350
                                    ? 0.57
                                    : (width < 313
                                    ? 0.45
                                    : 0.53)), // Adjust aspect ratio as needed
                              ),
                              itemCount: vehicles.length,
                              itemBuilder: (context, index) {
                                final category = vehicles[index];
                                print('Category Data: $category'); // Debug print
                                return RidesMainDubaiCard(
                                  name: category['name'],
                                  imageUrl: category['categoryVehicleImage'],
                                  price: category['minimumAmount'].toDouble(),
                                  baggage: category['noOfBaggage'],
                                  persons: category['noOfPeople'],
                                  rating: 4.0, id: category['_id'], // Assuming a default rating, adjust as needed
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
