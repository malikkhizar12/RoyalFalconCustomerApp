import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(Map<String, String> data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(Appurl.loginUrl, data);
      return response;
    } catch (e) {
      print('Login error in repository: $e');
      print('Login error in repository: ${e.toString()}');

      throw e; // Rethrow the exception for handling in ViewModel or UI
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(Appurl.signupUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
