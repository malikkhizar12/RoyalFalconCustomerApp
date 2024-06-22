import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    String userJson = jsonEncode(user.user?.toJson() ?? {});
    await prefs.setString('user', userJson);
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
    return UserModel(token: token, user: user);
  }

  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    if(kDebugMode){
      print("user removed");
    }
    return true;
  }
}
