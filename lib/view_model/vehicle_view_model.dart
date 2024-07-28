import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../repository/vehicle_repo.dart';

class VehicleViewModel with ChangeNotifier {
  final VehicleRepository _vehicleRepository = VehicleRepository();

  bool _loading = false;
  bool get loading => _loading;

  List<dynamic> _dubaiVehicles = [];
  List<dynamic> _abuDhabiVehicles = [];

  List<dynamic> get dubaiVehicles => _dubaiVehicles;
  List<dynamic> get abuDhabiVehicles => _abuDhabiVehicles;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchVehicleCategories(BuildContext context) async {
    setLoading(true);

    try {
      var box = await Hive.openBox('vehicleCategories');

      // Always fetch new data from API
      var dubaiResponse = await _fetchVehicleData('Dubai');
      if (dubaiResponse != null) {
        _dubaiVehicles = dubaiResponse;
        box.put('dubai', _dubaiVehicles);
      }

      var abuDhabiResponse = await _fetchVehicleData('Abu Dhabi');
      if (abuDhabiResponse != null) {
        _abuDhabiVehicles = abuDhabiResponse;
        box.put('abuDhabi', _abuDhabiVehicles);
      }

      setLoading(false);
    } catch (e) {
      setLoading(false);
      print('Error fetching vehicle categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching vehicle categories: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<List<dynamic>?> _fetchVehicleData(String location) async {
    try {
      var response = await _vehicleRepository.getVehicleCategories(location);
      if (response != null && response['vehicleCategories'] != null) {
        return response['vehicleCategories'];
      }
    } catch (e) {
      print('Error fetching data for $location: $e');
    }
    return null;
  }

  List<dynamic> getVehiclesByLocation(String location) {
    if (location == 'Dubai') {
      return _dubaiVehicles;
    } else if (location == 'Abu Dhabi') {
      return _abuDhabiVehicles;
    } else {
      return [];
    }
  }
}
