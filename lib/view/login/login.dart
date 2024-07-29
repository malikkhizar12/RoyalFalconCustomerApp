import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/driver_panel/home_screen/driver_bookings_list.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';
import '../../utils/utils/utils.dart';
import '../signup/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/company_logo.png'),
                  Image.asset('images/royal_falcon.png'),
                  SizedBox(height: 50.h),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF1A1E23),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                      },
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      obscuringCharacter: '*',
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: togglePasswordVisibility,
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color(0xFF1A1E23),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.h, top: 10.h, right: 20.w, left: 20.w),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: Color(0xFF0E1115), // Even darker color
                    ),
                    child: Column(
                      children: [
                        const Text('Or Sign up with', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 30.h),
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1E23),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle Google login
                            },
                            icon: Image.asset('images/google_logo.webp', width: 40.w, height: 40.h),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        ElevatedButton(
                          onPressed: () {
                            Map<String, String> data = {
                              'email': emailController.text,
                              'password': passwordController.text,
                            };
                            authViewModel.loginApi(data, context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.buttonColor),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 48)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                          child: authViewModel.loading
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ), // Show loading indicator
                          )
                              : Container(
                            width: double.infinity,
                            height: 48.h,
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: const Text(
                'Signup',
                style:  TextStyle(color: Colors.grey),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
