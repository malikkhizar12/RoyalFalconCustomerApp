import 'package:flutter/material.dart';
import 'package:royal_falcon/repository/auth_repository.dart';
import 'package:royal_falcon/utils/utils/form_validator.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  ValueNotifier<bool> passObscureText = ValueNotifier<bool>(true);
  ValueNotifier<bool> confirmPassObscureText = ValueNotifier<bool>(true);
  String selectedCountryCode = '+92';
  String? phoneNumberError,
      passwordError,
      nameError,
      emailError,
      confirmPasswordError;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> signupApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoading(true);
      dynamic response = await _authRepository.signupApi(data);
      print('Signup response: $response'); // Debugging log
      setLoading(false);
      return response != null;
    } catch (e) {
      setLoading(false);
      print('Signup error: $e'); // Debugging log
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

  bool validateForm() {
    // bool isValid = true;
    nameError = FormValidators.validateName(nameController.text.trim());
    phoneNumberError = FormValidators.validatePhoneNumber(phoneController.text);
    passwordError = FormValidators.validatePassword(passwordController.text);
    emailError = FormValidators.validateEmail(emailController.text);
    confirmPasswordError = FormValidators.validateConfirmPassword(
        passwordController.text, confirmPasswordController.text);
    print(confirmPasswordError);

    notifyListeners();

    // if (passwordController.text != confirmPasswordController.text) {
    //   passwordError = 'Passwords do not match';
    //   isValid = false;
    // }

    return confirmPasswordError == null &&
        nameError == null &&
        emailError == null &&
        phoneNumberError == null &&
        passwordError == null;
  }
}
