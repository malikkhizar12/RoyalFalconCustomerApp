import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rent_a_car/hourly_booking.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';

import '../../view_model/rides_booking_form_view_model.dart';
import '../widgets/custom_end_drawer.dart';
import '../Rides/Rides.dart';
import '../widgets/shimmer_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeScreenViewModel _homeScreenViewModel;

  @override
  void initState() {
    super.initState();
    _homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    _homeScreenViewModel.initializeData(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleViewModel>(context, listen: false).fetchVehicleCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RidesBookingFormViewModel model = RidesBookingFormViewModel(context, 0);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomEndDrawer(),
        backgroundColor: const Color(0xFF22262A),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Opacity(
                opacity: 0.08,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/home_background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('images/home_icon.png'),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Handle notifications button press
                                },
                                icon: Image.asset('images/notificaton_icon.png'),
                              ),
                              IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                },
                                icon: Image.asset('images/menu_icon.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Consumer<HomeScreenViewModel>(
                      builder: (context, homeScreenViewModel, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              "Best For Your Comfort",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(height: 20.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildCategoryChip(
                                      'Rides',
                                          () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Rides()
                                          )
                                          )
                                  ),
                                  _buildCategoryChip('Buses', () {
                                    // Handle Getaway tap
                                  }),
                                  _buildCategoryChip('Getaway', () {
                                    // Handle Explore tap
                                  }),
                                  _buildCategoryChip('Passport pro', () {
                                    // Handle Passport pro tap
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Consumer<VehicleViewModel>(
                              builder: (context, vehicleViewModel, child) {
                                if (vehicleViewModel.loading) {
                                  return FullScreenShimmerLoading();
                                } else if (vehicleViewModel.dubaiVehicles.isEmpty && vehicleViewModel.abuDhabiVehicles.isEmpty) {
                                  return Center(child: Text('No vehicles available'));
                                } else {
                                  return CarouselSlider(
                                    options: CarouselOptions(
                                      height: 210.0.h,
                                      enlargeCenterPage: true,
                                      autoPlay: false,
                                      aspectRatio: 16 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      viewportFraction: 0.8,
                                    ),
                                    items: (vehicleViewModel.dubaiVehicles + vehicleViewModel.abuDhabiVehicles)
                                        .map<Widget>((vehicle) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                            child: Image.network(vehicle['categoryVehicleImage'], fit: BoxFit.cover),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: SizedBox(
                                width: 0.8.sw,
                                height: 45.h,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.yellowAccent, Color(0xFFCF9D2C)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      "Royal Falcon Limousine",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Other Services",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(height: 10.h),
                            Consumer<VehicleViewModel>(
                              builder: (context, vehicleViewModel, child) {
                                if (vehicleViewModel.loading) {
                                  return FullScreenShimmerLoading();
                                } else {
                                  return Container(
                                    height: 210.0.h,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        _buildServiceCard('images/hourly_booking.webp', 'Hourly Bookings',() => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => HourlyBooking()
                                            )
                                        )),
                                        _buildServiceCard('images/activities_image.webp', 'Activities',(){}),
                                        _buildServiceCard('images/partner_up_image.webp', ' Partner Up ', (){}),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
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

  Widget _buildCategoryChip(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.yellowAccent, Color(0xFFCF9D2C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(String imagePath, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 180.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
