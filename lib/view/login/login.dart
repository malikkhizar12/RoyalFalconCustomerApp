import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
import 'package:royal_falcon/view/widgets/textfields.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';
import '../../utils/utils/utils.dart';
import '../signup/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Consumer<AuthViewModel>(
                builder: (BuildContext context, AuthViewModel model,
                        Widget? child) =>
                    Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/company_logo.png',
                      width: 0.5.sw,
                      height: 0.1.sh,
                    ),
                    Image.asset(
                      'assets/images/royal_falcon.png',
                      width: 0.6.sw,
                      height: 0.2.sh,
                    ),
                    SizedBox(height: 50.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          10.verticalSpace,
                          TextFieldWidget(
                            hintText: "Enter your email",
                            controller: model.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onSubmitted: (_) {
                              Utils.fieldFocusChange(
                                  context,
                                  model.emailFocusNode,
                                  model.passwordFocusNode);
                            },
                          ),
                          20.verticalSpace,
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          10.verticalSpace,
                          ValueListenableBuilder(
                            valueListenable: model.passObscureText,
                            builder:
                                (BuildContext context, value, Widget? child) =>
                                    TextFieldWidget(
                              hintText: "***********",
                              controller: model.passwordController,
                              keyboardType: TextInputType.text,
                              isPassword: true,
                              obscureText: model.passObscureText.value,
                              iconOnTap: () {
                                model.passObscureText.value =
                                    !model.passObscureText.value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          bottom: 30.h, top: 10.h, right: 20.w, left: 20.w),
                      width: 1.sw,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        color: Color(0xFF0E1115), // Even darker color
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Or Sign up with',
                            style: TextStyle(
                              color: AppColors.kWhiteColor,
                            ),
                          ),
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
                              icon: Image.asset(
                                  'assets/images/google_logo.webp',
                                  width: 40.w,
                                  height: 40.h),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ButtonWidget(
                            title: "LOGIN",
                            onTap: () {
                              Map<String, String> data = {
                                'email': model.emailController.text,
                                'password': model.passwordController.text,
                              };
                              model.loginApi(data, context);
                            },
                            width: 1.sw,
                            height: 50.h,
                            isShadow: true,
                            isLoading: model.loading,
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text(
                'Signup',
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
