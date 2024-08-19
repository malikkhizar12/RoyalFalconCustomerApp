import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/model/user_model.dart';
import 'package:royal_falcon/view_model/app_theme_vmodel.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel(this.context) {
    getCurrentLocation();
  }
  BuildContext context;
  String? userName;
  String? userEmail;
  GoogleMapController? mapController;
  Position? currentPosition;
  // bool _isInitialized = false;
  // bool _isVehicleDataLoaded = false;

  List<dynamic> _allVehicles = [];
  List<dynamic> _filteredVehicles = [];

  List<dynamic> get filteredVehicles => _filteredVehicles;

  void setUserModel(UserModel userModel) {
    userName = userModel.user?.name;
    userEmail = userModel.user?.email;
    // _isInitialized = true;
    notifyListeners(); // Notify listeners only when data changes
  }

  initializeData(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserModel? userData = await userViewModel.getUser();
    if (userData != null) {
      setUserModel(userData);
    }

    // Fetch vehicle data
    final vehicleViewModel =
        Provider.of<VehicleViewModel>(context, listen: false);
    await vehicleViewModel.fetchVehicleCategories(context);

    _allVehicles = [
      ...vehicleViewModel.dubaiVehicles,
      ...vehicleViewModel.abuDhabiVehicles,
    ];
    _filteredVehicles = List.from(_allVehicles);
    // _isVehicleDataLoaded = true;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredVehicles = List.from(_allVehicles);
    } else {
      _filteredVehicles = _allVehicles
          .where((element) => element['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // bool get isInitialized => _isInitialized;
  // bool get isVehicleDataLoaded => _isVehicleDataLoaded;

  void getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition();
    notifyListeners();
  }

  Future<void> setMapStyle() async {
    if (mapController != null) {
      final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
      final Brightness platformBrightness =
          View.of(context).platformDispatcher.platformBrightness;

      if (themeChanger.themeMode == ThemeMode.dark ||
          (themeChanger.themeMode == ThemeMode.system &&
              platformBrightness == Brightness.dark)) {
        // Load and apply the custom dark mode map style
        final String style =
            await rootBundle.loadString('assets/map_style.json');
        mapController!.setMapStyle(style);
      } else {
        // Use the default map style (no need to load any custom style)
        mapController!.setMapStyle(null);
      }
    }
  }
}
