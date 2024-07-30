import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../view_model/home_screen_view_model.dart';
import '../Rides/Rides.dart';
import '../rent_a_car/widgets/appbar.dart';
import '../widgets/home_screen_categories.dart';
import '../widgets/searchbar.dart';

class AllServices extends StatelessWidget {
  const AllServices({super.key});

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
                    const AppbarHourly(title: 'All Services'),
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
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              width: 1.sw,
              color: ColorConstants.backgroundColor,
              child: Column(
                children: [
                  Consumer<HomeScreenViewModel>(
                    builder: (context, homeScreenViewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: LinearGradient(
                                colors: [Color(0xFF3A3E41), Color(0xFF22262A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 286,
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Rides',
                                        imagePath: 'images/wheels.png',
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Rides(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Getaway',
                                        imagePath: 'images/getaway.png',
                                        // onTap: () => Get.to(GetAway()),
                                      ),
                                    ),
                                    const Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Explore',
                                        imagePath: 'images/explore.png',
                                        // onTap: () => Get.to(ExploreMain()),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Partner up',
                                        imagePath: 'images/partner.png',
                                      ),
                                    ),
                                    Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Passport pro',
                                        imagePath: 'images/passport_pro.png',
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                                const SizedBox(height: 20),

                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Consumer<HomeScreenViewModel>(
                    builder: (context, homeScreenViewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: LinearGradient(
                                colors: [Color(0xFF3A3E41), Color(0xFF22262A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 186,
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Hourly Booking',
                                        imagePath: 'images/wheels.png',
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Rides(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Bus',
                                        imagePath: 'images/getaway.png',
                                        // onTap: () => Get.to(GetAway()),
                                      ),
                                    ),
                                    const Expanded(
                                      child: HomeScreenCategories(
                                        categoryTitle: 'Explore',
                                        imagePath: 'images/explore.png',
                                        // onTap: () => Get.to(ExploreMain()),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),


                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
