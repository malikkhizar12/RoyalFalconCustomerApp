import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/signup/widgets/phone_number_field.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
import 'package:royal_falcon/view/widgets/textfield_widget.dart';
import 'package:royal_falcon/view_model/signup_view_model.dart';
import '../../utils/colors.dart';
import '../../utils/utils/utils.dart';
import '../../utils/routes/routes_names.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ChangeNotifierProvider(
            create: (BuildContext context) => SignupViewModel(),
            child: Consumer<SignupViewModel>(
              builder: (BuildContext context, model, Widget? child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/company_logo.png',
                          height: 80,
                        ),
                        Image.asset(
                          'images/royal_falcon.png',
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'Full Name',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.verticalSpace,
                  TextFieldWidget(
                    hintText: "Name",
                    controller: model.nameController,
                    keyboardType: TextInputType.text,
                  ),
                  10.verticalSpace,
                  if (model.nameError != null)
                    Text(
                      model.nameError!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  10.verticalSpace,
                  Text(
                    'Email',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.verticalSpace,
                  TextFieldWidget(
                    hintText: "Email Address",
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  10.verticalSpace,
                  if (model.emailError != null)
                    Text(
                      model.emailError!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  10.verticalSpace,
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.verticalSpace,
                  SignupPhoneNumberField(
                    controller: model.phoneController,
                    label: 'Phone Number',
                  ),
                  10.verticalSpace,
                  if (model.phoneNumberError != null)
                    Text(
                      model.phoneNumberError!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  10.verticalSpace,
                  Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: model.passObscureText,
                    builder: (BuildContext context, value, Widget? child) =>
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
                  10.verticalSpace,
                  if (model.passwordError != null)
                    Text(
                      model.passwordError!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  10.verticalSpace,
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  10.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: model.confirmPassObscureText,
                    builder: (BuildContext context, value, Widget? child) =>
                        TextFieldWidget(
                      hintText: "***********",
                      controller: model.confirmPasswordController,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      obscureText: model.confirmPassObscureText.value,
                      iconOnTap: () {
                        model.confirmPassObscureText.value =
                            !model.confirmPassObscureText.value;
                      },
                    ),
                  ),
                  10.verticalSpace,
                  if (model.confirmPasswordError != null)
                    Text(
                      model.confirmPasswordError!,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  40.verticalSpace,
                  ButtonWidget(
                    title: "Sign Up",
                    onTap: () async {
                      if (model.validateForm()) {
                        final fullPhoneNumber =
                            '${model.selectedCountryCode}${model.phoneController.text}';
                        final data = {
                          'name': model.nameController.text,
                          'email': model.emailController.text,
                          'phoneNumber': fullPhoneNumber,
                          'password': model.passwordController.text,
                        };

                        bool success = await model.signupApi(data, context);
                        if (success) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, RoutesNames.login, (route) => false);
                          Utils.flushBarMessage(
                              "Account Created Successfully", context);
                        }
                      }
                    },
                    width: 1.sw,
                    height: 50.h,
                    isShadow: true,
                    isLoading: model.loading,
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
                              decoration:
                                  TextDecoration.none, // Remove underline here
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
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
        ),
      ),
    );
  }
}
