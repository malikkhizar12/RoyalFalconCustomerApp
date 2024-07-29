import 'package:flutter/foundation.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import '../../model/user_model.dart';

class SplashServices {
  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<Map<String, dynamic>> checkAuthentication() async {
    UserModel? userModel = await getUserData();

    if (kDebugMode) {
      print("User Data: ${userModel?.toJson()}");
    }

    await Future.delayed(const Duration(seconds: 2));

    if (userModel == null || userModel.token == null || userModel.token!.isEmpty) {
      print("User is not authenticated");
      return {'authenticated': false};
    } else {
      print("User is authenticated");
      return {
        'authenticated': true,
        'role': userModel.user?.role ?? '',
        'userId': userModel.user?.id ?? '' // Ensure the userId is correctly accessed and handle null
      };
    }
  }
}
