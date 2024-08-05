import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/passport_pro/passport_pro_view.dart';
import 'package:royal_falcon/view/rent_a_car/hourly_booking.dart';
import '../../utils/colors.dart';
import '../../view_model/home_screen_view_model.dart';
import '../Rides/Rides.dart';
import '../partner_up/partner_up_view.dart';
import '../rent_a_bus/bus_booking.dart';
import '../rent_a_car/widgets/appbar.dart';
import '../widgets/home_screen_categories.dart';
import '../widgets/searchbar.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                          'images/hourly_booking_cover.png'), // Ensure you have this image in your assets
// =======
//                       image: AssetImage('assets/images/hourly_booking_cover.png'), // Ensure you have this image in your assets
// >>>>>>> main
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.zero, // Remove default padding
                  child: Column(
                    children: [
                      const AppbarHourly(title: 'All Services'),
                      SizedBox(
                          height:
                              100.h), // Adjust the height as per your design
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedSearchBar(
                          fillColor: Color(0xFFFFBC07),
                          textColor: Colors.white,
                          hintText: "Search",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: 1.sw,
                color: AppColors.backgroundColor,
                child: SingleChildScrollView(
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
                                    colors: [
                                      Color(0xFF3A3E41),
                                      Color(0xFF22262A)
                                    ],
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
                                          child: _buildAnimatedCategory(
                                            'Rides',
                                            () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => Rides(),
                                              ),
                                            ),
                                            'assets/images/wheels.png',
                                          ),
                                        ),
                                        Expanded(
                                          child: _buildAnimatedCategory(
                                            'Getaway',
                                            () {
                                              // Handle Getaway tap
                                            },
                                            'assets/images/getaway.png',
                                          ),
                                        ),
                                        Expanded(
                                          child: _buildAnimatedCategory(
                                            'Explore',
                                            () {
                                              // Handle Explore tap
                                            },
                                            'assets/images/explore.png',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildAnimatedCategory(
                                            'Partner up',
// <<<<<<< dev_usama
//                                             () {
//                                               // Handle Partner up tap
//                                             },
//                                             'images/partner.png',
// =======
                                                () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => PartnerUpView(),
                                              ),
                                            ),
                                            'assets/images/partner.png',
// >>>>>>> main
                                          ),
                                        ),
                                        Expanded(
                                          child: _buildAnimatedCategory(
                                            'Passport pro',
                                            () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PassportProView()));
                                              // Handle Passport pro tap
                                            },
                                            'assets/images/passport_pro.png',
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
                                    colors: [
                                      Color(0xFF3A3E41),
                                      Color(0xFF22262A)
                                    ],
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
                                          child: _buildAnimatedCategory(
                                            'Hourly Hire',
                                            () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HourlyBooking(),
                                              ),
                                            ),
                                            'assets/images/wheels.png',
                                          ),
                                        ),
                                        Expanded(
                                          child: _buildAnimatedCategory(
                                            'Rent A Bus',
// <<<<<<< dev_usama
//                                             () {
//                                               // Handle Rent A Bus tap
//                                             },
//                                             'images/bus_image.png',
// =======
                                                () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusBooking())),

                                            'assets/images/bus_image.png',
// >>>>>>> main
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

  Widget _buildAnimatedCategory(
      String label, VoidCallback onTap, String imageAsset) {
    return AnimatedScale(
      scale: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      child: HomeScreenCategories(
        categoryTitle: label,
        imagePath: imageAsset,
        onTap: onTap,
      ),
    );
  }
}
