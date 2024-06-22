import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import '../../model/user_model.dart';

class SplashServices {
  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<bool> checkAuthentication() async {
    UserModel? user = await getUserData();

    if (kDebugMode) {
      print("User Data: ${user?.toJson()}");
    }

    await Future.delayed(const Duration(seconds: 2));

    if (user == null || user.token == null || user.token!.isEmpty) {
      print("User is not authenticated");
      return false;
    } else {
      print("User is authenticated");
      return true;
    }
  }
}
