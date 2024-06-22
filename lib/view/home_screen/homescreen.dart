import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view_model/home_screen_view_model.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/model/user_model.dart';
import '../widgets/custom_end_drawer.dart';
import '../widgets/home_screen_categories.dart';
import '../widgets/searchbar.dart';
import '../Rides/Rides.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer:  CustomEndDrawer(),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      height: 49,
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
                            Text(
                              'Hello ${homeScreenViewModel.capitalizeFirstLetter(homeScreenViewModel.userName ?? "Guest")}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              homeScreenViewModel.userEmail ?? "Your Email",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const ElevatedSearchBar(
                              hintText: "Search",
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3E41),
                                border: Border.all(color: Colors.white, width: 0.4),
                              ),
                              height: 388,
                              width: 381,
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
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  Rides())),
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
                                          categoryTitle: 'Stay Local',
                                          imagePath: 'images/stay_local.png',
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
                                          categoryTitle: 'Invest in',
                                          imagePath: 'images/invest.png',
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
                                          categoryTitle: 'More services',
                                          imagePath: 'images/more_services.png',
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
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
