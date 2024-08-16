import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:royal_falcon/model/user_model.dart';
import 'package:royal_falcon/repository/auth_repository.dart';
import 'package:royal_falcon/view_model/user_view_model.dart';
import 'package:royal_falcon/utils/utils/utils.dart';
import '../utils/routes/routes_names.dart';

class AuthViewModel extends ChangeNotifier {
  final UserViewModel userViewModel = UserViewModel();
  final AuthRepository _authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  ValueNotifier<bool> passObscureText = ValueNotifier<bool>(true);

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoading(true);
      dynamic response = await _authRepository.loginApi(data);

      if (response != null) {
        String token = response['token'];
        Map<String, dynamic> userData = response['user'];
        String role = userData['role']; // Extract role from user data
        // Create a UserModel instance
        UserModel userModel = UserModel(
          token: token,
          user: User.fromJson(userData),
        );

        // Save the user data using UserViewModel
        await userViewModel.saveUser(userModel);

        setLoading(false);

        // Logging the navigation details
        print("Role: $role");
        print("Navigating to the appropriate screen based on role");

        // Navigate based on role
        if (role == 'driver') {
          print("Navigating to DriverHome with userId: ${userModel.user?.id}");
          Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesNames.driverHome,
              arguments: userModel.user?.id,
              (route) => false);
        } else {
          print("Navigating to Home");
          Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesNames.home,
              arguments: userModel,
              (route) => false);
        }
        emailController.clear();
        passwordController.clear();
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      setLoading(false);
      String errorMessage;
      try {
        var errorResponse = jsonDecode(e.toString());
        print(errorResponse);
        errorMessage = errorResponse['message'] ?? 'Login failed';
      } catch (jsonError) {
        errorMessage = 'Login failed: $e';
      }
      Utils.errorMessage(errorMessage, context);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      userViewModel.removeUser();
      Navigator.pushReplacementNamed(context, RoutesNames.login);
    } catch (e) {
      print('Logout error: $e'); // Handle any logout errors
    }
  }
}
