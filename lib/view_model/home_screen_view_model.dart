import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/model/user_model.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/view_model/vehicle_view_model.dart';

class HomeScreenViewModel with ChangeNotifier {
  String? userName;
  String? userEmail;
  bool _isInitialized = false;
  bool _isVehicleDataLoaded = false;

  List<dynamic> _allVehicles = [];
  List<dynamic> _filteredVehicles = [];

  List<dynamic> get filteredVehicles => _filteredVehicles;

  void setUserModel(UserModel userModel) {
    userName = userModel.user?.name;
    userEmail = userModel.user?.email;
    _isInitialized = true;
    notifyListeners(); // Notify listeners only when data changes
  }

   initializeData(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserModel? userData = await userViewModel.getUser();
    if (userData != null) {
      setUserModel(userData);
    }

    // Fetch vehicle data
    final vehicleViewModel = Provider.of<VehicleViewModel>(context, listen: false);
    await vehicleViewModel.fetchVehicleCategories(context);

    _allVehicles = [
      ...vehicleViewModel.dubaiVehicles,
      ...vehicleViewModel.abuDhabiVehicles,
    ];
    _filteredVehicles = List.from(_allVehicles);
    _isVehicleDataLoaded = true;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredVehicles = List.from(_allVehicles);
    } else {
      _filteredVehicles = _allVehicles
          .where((element) => element['name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  bool get isInitialized => _isInitialized;
  bool get isVehicleDataLoaded => _isVehicleDataLoaded;

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
