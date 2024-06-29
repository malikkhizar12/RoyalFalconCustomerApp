import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarCustom extends StatelessWidget {
  final String title;
  const AppbarCustom({

    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20, // Adjust the radius to control the size of the circle
            backgroundColor: Color(0xFF2D343C), // Background color of the circle
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, color: Color(0xFFCF9D2C)),
              iconSize: 23,
            ),
          ),
          const Spacer(flex: 4,),

          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17.sp),
          ),
          const Spacer(flex: 2,),
          Row(
            children: [
              IconButton(
                onPressed: () {

                },

                icon: Image.asset('images/about_icon.png'),
              ),
              IconButton(
                onPressed: () {

                },

                icon: Image.asset('images/heart_like.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
