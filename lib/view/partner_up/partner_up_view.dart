import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/partner_up/widgets/partner_up_card.dart';
import '../widgets/appbarcustom.dart';

class PartnerUpView extends StatefulWidget {
  const PartnerUpView({super.key});

  @override
  _PartnerUpViewState createState() => _PartnerUpViewState();
}

class _PartnerUpViewState extends State<PartnerUpView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const AppbarCustom(title: "Partner Up"),
            SizedBox(height: 0.06.sh),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: 1.sw,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Start Earning Now!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. Eget nunc facilisis a quis. Quam nam natoque mus orci. Ut arcu quis mauris tortor aliquam semper euismod. Nec egestas vitae urna quis id lacus.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      PartnerCard(
                        imagePath: "assets/images/car_image.png", // Replace with the correct path
                        title: "Corporate Vendor",
                        description: "Lorem ipsum dolor sit amet consectetur. Tellus augue suspendisse tortor sodales pellentesque duis leo. Cursus amet nec maecenas risus.",
                      ),
                      SizedBox(height: 20.h),
                      PartnerCard(
                        imagePath: "assets/images/home_background.jpg", // Replace with the correct path
                        title: "Travel and Tourism",
                        description: "Lorem ipsum dolor sit amet consectetur. Tellus augue suspendisse tortor sodales pellentesque duis leo. Cursus amet nec maecenas risus.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
