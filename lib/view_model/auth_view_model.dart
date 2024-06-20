import 'package:flutter/material.dart';
import 'package:royal_falcon/repository/auth_repository.dart';
import '../utils/routes/routes_names.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoading(true);
      dynamic response = await _authRepository.loginApi(data);

      if (response != null) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesNames.home);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      setLoading(false);
      String errorMessage = 'Login failed: $e';

      // Check for specific error messages
      if (e.toString().contains('Invalid email')) {
        errorMessage = 'Incorrect email';
      } else if (e.toString().contains('Error During Communication')) {
        errorMessage = 'Unauthorized User';
      }

      // Show snackbar with appropriate error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<bool> signupApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoading(true);
      dynamic response = await _authRepository.signupApi(data);
      setLoading(false);
      return response != null;
    } catch (e) {
      setLoading(false);
      print('Signup error: $e'); // Print the error for debugging
      if (e.toString().contains('email already exists')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already exists'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.toString().contains('Error in creating user')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone number already exists'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      // Perform logout actions here, such as clearing tokens, resetting state, etc.
      // Example: Clear authentication tokens or session information

      // After clearing, navigate to the login page
      Navigator.pushReplacementNamed(context, RoutesNames.login);
    } catch (e) {
      print('Logout error: $e'); // Handle any logout errors
    }
  }
}
