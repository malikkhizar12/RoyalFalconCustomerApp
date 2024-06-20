
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/signup/widgets/phone_number_field.dart';
import 'package:royal_falcon/view/signup/widgets/textfields.dart';
import '../../utils/colors.dart';
import '../../utils/utils/form_validator.dart';
import '../../utils/utils/utils.dart';
import '../login/login.dart';
import '../../view_model/auth_view_model.dart';
import '../../utils/routes/routes_names.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String selectedCountryCode = '+92';
  String? phoneNumberError;
  String? passwordError;
  String? nameError;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Center(
                child: Column(
                  children: [
                    Image.asset('images/company_logo.png', height: 80),
                    Image.asset('images/royal_falcon.png', height: 40),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              buildTextField('Full Name', nameController, TextInputType.text),
              if (nameError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    nameError!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ),
              SizedBox(height: 20.h),
              buildTextField('Email Address', emailController, TextInputType.emailAddress),
              SizedBox(height: 20.h),
              SignupPhoneNumberField(controller: phoneController, label: 'Phone Number'),
              if (phoneNumberError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    phoneNumberError!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ),
              SizedBox(height: 20.h),
              buildTextField('Password', passwordController, TextInputType.visiblePassword, obscureText: true),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    passwordError!,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                ),
              SizedBox(height: 20.h),
              buildTextField('Confirm Password', confirmPasswordController, TextInputType.visiblePassword, obscureText: true),
              SizedBox(height: 35.h),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_validateForm()) {
                        final fullPhoneNumber = '$selectedCountryCode${phoneController.text}';
                        final data = {
                          'name': nameController.text,
                          'email': emailController.text,
                          'phoneNumber': fullPhoneNumber,
                          'password': passwordController.text,
                        };

                        bool success = await authViewModel.signupApi(data, context);
                        if (success) {
                          Navigator.pushReplacementNamed(context, RoutesNames.login);
                          Utils.flushBarMessage("Account Created Successfully", context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700), // Button color
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 100.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: authViewModel.loading
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Have An Account? ',
                    style: const TextStyle(color: Colors.grey),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.none, // Remove underline here
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    bool isValid = true;

    setState(() {
      nameError = FormValidators.validateName(nameController.text.trim());
      phoneNumberError = FormValidators.validatePhoneNumber(phoneController.text);
      passwordError = FormValidators.validatePassword(passwordController.text);

      if (passwordController.text != confirmPasswordController.text) {
        passwordError = 'Passwords do not match';
        isValid = false;
      }
    });

    return isValid && nameError == null && phoneNumberError == null && passwordError == null;
  }
}
