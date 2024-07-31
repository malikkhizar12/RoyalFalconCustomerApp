import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/all_services/all_services_main_page.dart';
import 'package:royal_falcon/view/rent_a_car/hourly_booking.dart';
import 'package:royal_falcon/view/widgets/small_shimmer.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';
import '../../view_model/rides_booking_form_view_model.dart';
import '../widgets/custom_end_drawer.dart';
import '../Rides/Rides.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeScreenViewModel _homeScreenViewModel;
  late Future<void> _initializeDataFuture;
  late AnimationController _animationController;
  bool _isVisible = false;

  int _current = 0; // To track the current page

  @override
  void initState() {
    super.initState();
    _homeScreenViewModel =
        Provider.of<HomeScreenViewModel>(context, listen: false);
    _initializeDataFuture = _homeScreenViewModel.initializeData(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleViewModel>(context, listen: false)
          .fetchVehicleCategories(context);
    });

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
    final RidesBookingFormViewModel model =
    RidesBookingFormViewModel(context, 0);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomEndDrawer(),
        backgroundColor: const Color(0xFF22262A),
        body: FutureBuilder<void>(
          future: _initializeDataFuture,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.connectionState);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ConnectionState connectionState) {
    return SingleChildScrollView(
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
                ElevatedSearchBar(
                  fillColor: Color(0xFFFFBC07),
                  textColor: Colors.white,
                ),
                if (connectionState == ConnectionState.waiting)
                  Container(
                    height: 210.0.h,
                    child: SmallShimmerLoading(),
                  )
                else
                  Consumer<VehicleViewModel>(
                    builder: (context, vehicleViewModel, child) {
                      if (vehicleViewModel.dubaiVehicles.isEmpty &&
                          vehicleViewModel.abuDhabiVehicles.isEmpty) {
                        return Center(child: Text('No vehicles available'));
                      } else {
                        final limitedVehicles =
                        (vehicleViewModel.dubaiVehicles +
                            vehicleViewModel.abuDhabiVehicles)
                            .take(6)
                            .toList();
                        return Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 210.0.h,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                Duration(milliseconds: 700),
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: limitedVehicles.map<Widget>((vehicle) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      vehicle['categoryVehicleImage'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(limitedVehicles.length,
                                      (index) {
                                    return Container(
                                      width: 10.0,
                                      height: 6.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: _current == index
                                            ? Color(0xFFFFBC07)
                                            : Color.fromRGBO(0, 0, 0, 0.4),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AllServices()));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAnimatedCategoryChip(
                      'Rides',
                          () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Rides()),
                      ),
                      'images/car_image.png',
                    ),
                    _buildAnimatedCategoryChip(
                      'Buses',
                          () {
                        // Handle Buses tap
                      },
                      'images/dubai_safari.jpg',
                    ),
                    _buildAnimatedCategoryChip(
                      'Getaway',
                          () {
                        // Handle Getaway tap
                      },
                      'images/rides_cover.png',
                    ),
                    _buildAnimatedCategoryChip(
                      'Passport',
                          () {
                        // Handle Passport pro tap
                      },
                      'images/stay_local.png',
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Consumer<VehicleViewModel>(
                  builder: (context, vehicleViewModel, child) {
                    return Container(
                      height: 210.0.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildServiceCard(
                              'images/hourly_booking.webp',
                              'Hourly Bookings',
                                  () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HourlyBooking()),
                              )),
                          _buildServiceCard('images/activities_image.webp',
                              'Activities', () {}),
                          _buildServiceCard('images/partner_up_image.webp',
                              ' Partner Up ', () {}),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCategoryChip(
      String label, VoidCallback onTap, String imageAsset) {
    return Expanded(
      child: AnimatedScale(
        scale: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1300),
        curve: Curves.easeInOut,
        child: _buildCategoryChip(label, onTap, imageAsset),
      ),
    );
  }

  Widget _buildCategoryChip(
      String label, VoidCallback onTap, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100.w, // Adjust width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  imageAsset,
                  height: 70.h, // Adjust height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      String imagePath, String title, VoidCallback onTap) {
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
