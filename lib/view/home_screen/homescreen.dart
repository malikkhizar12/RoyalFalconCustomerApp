import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/all_services/all_services_main_page.dart';
// <<<<<<< dev_usama
// import 'package:royal_falcon/view/passport_pro/passport_pro_view.dart';
// import 'package:royal_falcon/view/rent_a_car/hourly_booking.dart';
// =======
import 'package:royal_falcon/view/rent_a_bus/bus_booking.dart';
// >>>>>>> main
import 'package:royal_falcon/view/widgets/small_shimmer.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';
import '../../view_model/rides_booking_form_view_model.dart';
import '../widgets/custom_end_drawer.dart';
import '../Rides/Rides.dart';
import '../widgets/searchbar.dart';

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
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  CameraPosition? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    _initializeDataFuture = _homeScreenViewModel.initializeData(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocation();
      Provider.of<VehicleViewModel>(context, listen: false).fetchVehicleCategories(context);
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _startAnimation();
    _addMarkers();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
      _animationController.forward();
    });
  }

  void _addMarkers() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('vehicle1'),
          position: LatLng(24.466667, 54.366669),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('vehicle2'),
          position: LatLng(24.477667, 54.356669),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 13,
        );
      });
      print("Current position: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      print("Error in getting location: $e");
    }
  }

  Future<void> _setMapStyle() async {
    if (_mapController != null) {
      final String style = await rootBundle.loadString('assets/map_style.json');
      _mapController!.setMapStyle(style);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RidesBookingFormViewModel model = RidesBookingFormViewModel(context, 0);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomEndDrawer(),
      backgroundColor: const Color(0xFF22262A),
      body: SafeArea(
        child: FutureBuilder<void>(
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
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.r,
                        spreadRadius: 2.r,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 15.h, bottom: 20.h),
                  height: 60.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/home_icon.png',

                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle notifications button press
                            },
                            icon: Image.asset(
                              'assets/images/notificaton_icon.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                            icon: Image.asset(
                              'assets/images/menu_icon.png',
                              height: 30.h,
                              width: 30.w,
                            ),
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
                    color: ColorConstants.backgroundColor,
                    height: 210.0.h,
                    child: SmallShimmerLoading(),
                  )
                else
                  Consumer<VehicleViewModel>(
                    builder: (context, vehicleViewModel, child) {
                      if (vehicleViewModel.dubaiVehicles.isEmpty && vehicleViewModel.abuDhabiVehicles.isEmpty) {
                        return Center(child: Text('No vehicles available', style: TextStyle(color: Colors.white, fontSize: 14.sp)));
                      } else {
// <<<<<<< dev_usama
//                         final limitedVehicles =
//                             (vehicleViewModel.dubaiVehicles +
//                                     vehicleViewModel.abuDhabiVehicles)
//                                 .take(6)
//                                 .toList();
// =======
                        final limitedVehicles = (vehicleViewModel.dubaiVehicles + vehicleViewModel.abuDhabiVehicles)
                            .take(6)
                            .toList();
// >>>>>>> main
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
// <<<<<<< dev_usama
//                                 autoPlayAnimationDuration:
//                                     Duration(milliseconds: 700),
// =======
                                autoPlayAnimationDuration: Duration(milliseconds: 700),
// >>>>>>> main
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: limitedVehicles.map<Widget>((vehicle) {
                                return Container(
                                  width: 1.sw,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                                  decoration: BoxDecoration(
// <<<<<<< dev_usama
//                                     color: Colors.grey,
// =======
                                    color: ColorConstants.backgroundColor,
// >>>>>>> main
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10.r,
                                        spreadRadius: 2.r,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
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
// <<<<<<< dev_usama
//                               children: List.generate(limitedVehicles.length,
//                                   (index) {
//                                 return Container(
//                                   width: 10.0,
//                                   height: 6.0,
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: 10.0, horizontal: 2.0),
// =======
                              children: List.generate(limitedVehicles.length, (index) {
                                return Container(
                                  width: 10.0.w,
                                  height: 6.0.h,
                                  margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 2.0.w),
// >>>>>>> main
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
// <<<<<<< dev_usama
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AllServices()));
// =======
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllServices()));
// >>>>>>> main
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
// <<<<<<< dev_usama
//                       () => Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => Rides()),
//                       ),
//                       'images/car_image.png',
//                     ),
//                     _buildAnimatedCategoryChip(
//                       'Buses',
//                       () {
//                         // Handle Buses tap
//                       },
//                       'images/dubai_safari.jpg',
// =======
                          () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Rides())),
                      'assets/images/car_image.png',
                    ),
                    _buildAnimatedCategoryChip(
                      'Buses',
                          () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusBooking())),

                      'assets/images/bus_image.png',
// >>>>>>> main
                    ),
                    _buildAnimatedCategoryChip(
                      'Getaway',
                      () {
                        // Handle Getaway tap
                      },
                      'assets/images/rides_cover.png',
                    ),
                    _buildAnimatedCategoryChip(
                      'Passport',
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassportProView()));
                      },
                      'assets/images/stay_local.png',
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                ),
                SizedBox(height: 10.h),
// <<<<<<< dev_usama
//                 Consumer<VehicleViewModel>(
//                   builder: (context, vehicleViewModel, child) {
//                     return Container(
//                       height: 210.0.h,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           _buildServiceCard(
//                               'images/hourly_booking.webp',
//                               'Hourly Bookings',
//                               () => Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                         builder: (context) => HourlyBooking()),
//                                   )),
//                           _buildServiceCard('images/activities_image.webp',
//                               'Activities', () {}),
//                           _buildServiceCard('images/partner_up_image.webp',
//                               ' Partner Up ', () {}),
//                         ],
// =======
                Container(
                  height: 210.0.h,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SearchLocationPage()), // Replace SearchLocationPage with your desired page
                          // );
                        },
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return _initialCameraPosition != null
                                ? GoogleMap(
                              zoomControlsEnabled: false,
                              myLocationEnabled: true,
                              onMapCreated: (controller) {
                                _mapController = controller;
                                _setMapStyle(); // Ensure the map style is set after the controller is initialized
                              },
                              initialCameraPosition: _initialCameraPosition!,
                              markers: _markers,
                              polylines: _polylines,
                            )
                                : Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFFBC07),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 10.w,
                        right: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SearchLocationPage()), // Replace SearchLocationPage with your desired page
                            // );
                          },
                          child: Container(
                            height: 50.h,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.5)),
                              color: Colors.grey.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.black),
                                SizedBox(width: 10.w),
                                Text(
                                  "Search Location",
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
// >>>>>>> main
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCategoryChip(String label, VoidCallback onTap, String imageAsset) {
    return Expanded(
      child: AnimatedScale(
        scale: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1300),
        curve: Curves.easeInOut,
        child: _buildCategoryChip(label, onTap, imageAsset),
      ),
    );
  }

  Widget _buildCategoryChip(String label, VoidCallback onTap, String imageAsset) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0.w),
      child: GestureDetector(
        onTap: onTap,
// <<<<<<< dev_usama
//         child: Container(
//           width: 100.w, // Adjust width as needed
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.transparent,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Image.asset(
//                   imageAsset,
//                   height: 70.h, // Adjust height as needed
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceCard(String imagePath, String title, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: onTap,
//             child: Container(
//               width: 180.w,
// =======
        child: Column(
          children: [
            Container(

              width: 100.w, // Adjust width as needed
// >>>>>>> main
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Image.asset(
                    imageAsset,
                    height: 70.h, // Adjust height as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                ],
              ),
            ),
            SizedBox(height: 8.0.h),
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
    );
  }
}
