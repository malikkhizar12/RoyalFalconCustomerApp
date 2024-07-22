import 'package:hive/hive.dart';
import '../resources/app_url.dart';
import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class VehicleRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  VehicleRepository() {
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    await Hive.openBox('vehicleCategories');
  }

  Future<dynamic> getVehicleCategories(String city) async {
    try {
      final String url = '${Appurl.vehicle}?city=$city';
      dynamic response = await _apiServices.getGetApiResponse(url);
      print('Vehicle Repository Response for $city: $response'); // Debug print
      return response;
    } catch (e) {
      print('Error fetching vehicle categories: $e');
      throw e;
    }
  }
}
