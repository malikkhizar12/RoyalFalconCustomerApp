import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/user_model.dart';
import '../model/driver_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    String userJson = jsonEncode(user.user?.toJson() ?? {});
    await prefs.setString('user', userJson);
    print('User saved: $userJson');

    if (user.user?.role == 'driver' && user.user?.driverDetails != null) {
      String driverJson = jsonEncode(user.user?.driverDetails?.toJson() ?? {});
      await prefs.setString('driverDetails', driverJson);
      print('Driver details saved: $driverJson');
    }
    notifyListeners();
    return true;
  }

  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userJson = prefs.getString('user');
    if (token == null || token.isEmpty || userJson == null) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(userJson);
    User user = User.fromJson(userMap);
    print('User fetched: $userJson');
    return UserModel(token: token, user: user);
  }

  Future<Driver?> getDriverDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson == null) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(userJson);
    if (userMap['role'] == 'driver') {
      return Driver.fromJson(userMap['driverDetails']);
    }
    return null;
  }
  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('driverDetails');
    if (kDebugMode) {
      print("User removed");
    }
    return true;
  }
}
