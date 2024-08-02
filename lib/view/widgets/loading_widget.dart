import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  const LoadingWidget({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              color: color,
            )
          : Platform.isIOS
              ? CupertinoActivityIndicator(
                  color: color,
                )
              : SizedBox(),
    );
  }
}
