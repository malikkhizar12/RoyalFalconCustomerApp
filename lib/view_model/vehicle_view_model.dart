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
    try {
      // Open Hive box
      var box = await Hive.openBox('vehicleCategories');

      // Show cached data if available
      var cachedDubaiVehicles = box.get('dubai');
      var cachedAbuDhabiVehicles = box.get('abuDhabi');

      if (cachedDubaiVehicles != null && cachedAbuDhabiVehicles != null) {
        _dubaiVehicles = cachedDubaiVehicles;
        _abuDhabiVehicles = cachedAbuDhabiVehicles;
        notifyListeners();
      }

      // Fetch new data from API
      setLoading(true);

      // Clear old data in Hive
      await box.clear();

      // Fetch Dubai vehicles
      var dubaiResponse = await _vehicleRepository.getVehicleCategories('Dubai');
      if (dubaiResponse != null && dubaiResponse['vehicleCategories'] != null) {
        _dubaiVehicles = dubaiResponse['vehicleCategories'];
        box.put('dubai', _dubaiVehicles);
      }

      // Fetch Abu Dhabi vehicles
      var abuDhabiResponse = await _vehicleRepository.getVehicleCategories('Abu Dhabi');
      if (abuDhabiResponse != null && abuDhabiResponse['vehicleCategories'] != null) {
        _abuDhabiVehicles = abuDhabiResponse['vehicleCategories'];
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
