import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';

import '../../view_model/app_theme_vmodel.dart';

class Utils {
  static void toggleTheme(BuildContext context) {


    final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
    themeChanger.setTheme(
      themeChanger.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  static flushBarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
      ),
    );
  }

  static successMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.kWhiteColor,
          fontFamily: 'Monstreal',
        ),
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ));
  }

  static errorMessage(String title, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.kWhiteColor,
          fontFamily: 'Monstreal',
        ),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      // animation: ,
    ));
  }
}
