import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{

  static void fieldFocusChange(BuildContext context , FocusNode current, FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
    backgroundColor: Colors.black,
    toastLength: Toast.LENGTH_LONG,
    textColor: Colors.white);
  }

  static flushBarMessage(String message,BuildContext context){
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,

        )
    );
  }
}