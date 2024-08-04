import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/loading_widget.dart';

class ButtonWidget extends StatelessWidget {
  final Color loadingColor, fontColor, buttonColor;
  final String title;
  final double height, width, fontSize, borderRadius;
  final bool isLoading, isShadow;
  final VoidCallback onTap;
  const ButtonWidget({
    super.key,
    this.height = 46,
    this.width = 300,
    this.isLoading = false,
    this.loadingColor = Colors.white,
    required this.title,
    this.fontColor = Colors.white,
    this.fontSize = 16,
    this.buttonColor = Colors.transparent,
    this.borderRadius = 13,
    this.isShadow = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor == Colors.transparent
                ? AppColors.buttonColor
                : buttonColor,
            borderRadius: BorderRadius.circular(borderRadius.r),
            boxShadow: isShadow
                ? [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 4.0,
                      offset: Offset(0, 0),
                      color: AppColors.buttonColor.withOpacity(0.25),
                    )
                  ]
                : []),
        child: isLoading
            ? LoadingWidget(
                color: loadingColor,
              )
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize.sp,
                    fontWeight: FontWeight.w600,
                    color: fontColor,
                  ),
                ),
              ),
      ),
    );
  }
}
