import 'package:flutter/material.dart';
import 'package:royal_falcon/repository/auth_repository.dart';
import 'package:royal_falcon/view/home_screen/homescreen.dart';

import '../utils/routes/routes_names.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _loading= false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading= value;
    notifyListeners();

  }

  Future<void> loginApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoading(true) ;
      // Call the loginApi method from AuthRepository
      dynamic response = await _authRepository.loginApi(data);

      if (response != null) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesNames.home);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      setLoading(false);
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
