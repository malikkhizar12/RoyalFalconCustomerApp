import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/rides_booking_form_view_model.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../../utils/colors.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/home_screen_categories.dart';
import '../Rides/Rides.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;
  double? pickUpLatitude, pickUpLongitude, dropOffLatitude, dropOffLongitude;
  String pickupLocationName = '';
  String dropOffLocationName = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeScreenViewModel _homeScreenViewModel;

  @override
  void initState() {
    super.initState();
    _homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    _homeScreenViewModel.initializeData(context);
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
                padding: const EdgeInsets.only(right: 20,left: 20, top: 10),
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
                                      Expanded(
                                        child: HomeScreenCategories(
                                          categoryTitle: 'More services',
                                          imagePath: 'images/more_services.png',
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
            ],
          ),
        ),
      ),
    );
  }
}
