import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view_model/auth_view_model.dart';
import 'package:royal_falcon/view_model/profile_screen_view_model.dart';

import '../widgets/appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final AuthViewModel authViewModel= AuthViewModel();

  @override
  Widget build(BuildContext context) {
    // Initialize screen utilities
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // Design size for iPhone X
    );

    // Determine screen orientation
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider(
      create: (context) => ProfileScreenViewModel()..initializeData(context),
      child: Consumer<ProfileScreenViewModel>(
        builder: (context, viewModel, child) {
          if (!viewModel.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: const CustomAppBar(
                title: '',
                color: Colors.black,
                bgColor: Colors.black,
              ),
              body: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey,
                          backgroundImage: viewModel.profileImagePath != null
                              ? FileImage(File(viewModel.profileImagePath!))
                              : null,
                          child: viewModel.profileImagePath == null
                              ? Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => viewModel.pickImage(context),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    viewModel.userName ?? "User Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    viewModel.userEmail ?? "user@example.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3E41),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isPortrait ? 35.w : 25.w,
                            vertical: isPortrait ? 30.h : 20.h,
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: viewModel.userName,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF333639),
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: viewModel.userEmail,
                                    style: TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF333639),
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: viewModel.userGender,
                                    dropdownColor: Colors.black,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF333639),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      viewModel.saveGender(value);
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: viewModel.userCountry,
                                    dropdownColor: Colors.black,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF333639),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    items: <String>[
                                      'USA',
                                      'Canada',
                                      'UK',
                                      'Australia',
                                      'Germany',
                                      'France'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      viewModel.saveCountry(value);
                                    },
                                  ),
                                  SizedBox(height: 30.h),
                                  Center(
                                    child: SizedBox(
                                      width: 242.w,
                                      height: 48.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          authViewModel.logout(context);
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(),
                                          ),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xFFCC001E)),
                                        ),
                                        child: Text(
                                          "Logout",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
