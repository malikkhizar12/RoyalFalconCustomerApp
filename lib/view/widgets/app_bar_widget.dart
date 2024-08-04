import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? shareOnTap, favoriteOnTap;
  const AppBarWidget({
    super.key,
    required this.title,
    this.shareOnTap,
    this.favoriteOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
          color: AppColors.kWhiteColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.kBlackColor,
      foregroundColor: AppColors.kPrimaryColor,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: shareOnTap,
          icon: Icon(
            Icons.share_outlined,
            color: AppColors.kPrimaryColor,
          ),
        ),
        IconButton(
          onPressed: favoriteOnTap,
          icon: Icon(
            Icons.favorite_border,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
