import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../repository/vehicle_repo.dart';
import '../resources/app_url.dart';

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
      setLoading(true);

      var box = await Hive.openBox('vehicleCategories');

      // Fetch Dubai vehicles
      if (box.containsKey('dubai')) {
        _dubaiVehicles = box.get('dubai');
      } else {
        var dubaiResponse = await _vehicleRepository.getVehicleCategories('Dubai');
        if (dubaiResponse != null && dubaiResponse['vehicleCategories'] != null) {
          _dubaiVehicles = dubaiResponse['vehicleCategories'].map((category) {
            if (category['categoryVehicleImage'] != null) {
              category['categoryVehicleImage'] = Appurl.vehicleImages + category['categoryVehicleImage'];
            }
            return category;
          }).toList();
          box.put('dubai', _dubaiVehicles);
        }
      }

      // Fetch Abu Dhabi vehicles
      if (box.containsKey('abuDhabi')) {
        _abuDhabiVehicles = box.get('abuDhabi');
      } else {
        var abuDhabiResponse = await _vehicleRepository.getVehicleCategories('Abu Dhabi');
        if (abuDhabiResponse != null && abuDhabiResponse['vehicleCategories'] != null) {
          _abuDhabiVehicles = abuDhabiResponse['vehicleCategories'].map((category) {
            if (category['categoryVehicleImage'] != null) {
              category['categoryVehicleImage'] = Appurl.vehicleImages + category['categoryVehicleImage'];
            }
            return category;
          }).toList();
          box.put('abuDhabi', _abuDhabiVehicles);
        }
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
