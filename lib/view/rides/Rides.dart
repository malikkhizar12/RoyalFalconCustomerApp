import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';
import 'package:royal_falcon/view/rides/rides_main_dubai_card.dart';
import '../../utils/colors.dart';
import '../widgets/booking_type.dart';
import '../widgets/custom_end_drawer.dart';
import 'location_buttons.dart';
import '../widgets/shimmer_effect.dart';

class Rides extends StatefulWidget {
  Rides({super.key});

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  String selectedLocation = 'Dubai';
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleViewModel>(context, listen: false).fetchVehicleCategories(context);
    });
  }

  void _onLocationChanged(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldkey,
        endDrawer: CustomEndDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/rides_cover.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(height: 100.h),
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
                      SizedBox(height: 30.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        decoration: const BoxDecoration(
                          color: Color(0xFF35383B),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Explore More Popular Cars",
                              style: TextStyle(color: Colors.white, fontSize: 25.sp),
                            ),
                            SizedBox(height: 8.h),
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
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: width > 392
                                            ? 0.60
                                            : (width > 350
                                            ? 0.57
                                            : (width < 313 ? 0.45 : 0.53)), // Adjust aspect ratio as needed
                                      ),
                                      itemCount: vehicles.length,
                                      itemBuilder: (context, index) {
                                        final category = vehicles[index];
                                        print('Category Data: $category'); // Debug print
                                        return RidesMainDubaiCard(
                                          city: selectedLocation,
                                          name: category['name'],
                                          imageUrl: category['categoryVehicleImage'],
                                          price: category['minimumAmount'].toDouble(),
                                          baggage: category['noOfBaggage'],
                                          persons: category['noOfPeople'],
                                          rating: 4.0,
                                          id: category['_id'], // Assuming a default rating, adjust as needed
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
                  Positioned(
                    top: width > 435 ? MediaQuery.of(context).size.height * 0.26 : MediaQuery.of(context).size.height * 0.18,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: BookingType(),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    left: 20.w,
                    child: CircleAvatar(
                      radius: 20, // Adjust the radius to control the size of the circle
                      backgroundColor: Color(0xFF2D343C), // Background color of the circle
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFCF9D2C)),
                        iconSize: 23,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
