import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/passport_pro/passport_pro_success_view.dart';
import 'package:royal_falcon/view/signup/widgets/phone_number_field.dart';
import 'package:royal_falcon/view/widgets/app_bar_widget.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
import 'package:royal_falcon/view/widgets/textfields.dart';

class PartnerUpFormView extends StatefulWidget {
  const PartnerUpFormView({super.key});

  @override
  State<PartnerUpFormView> createState() =>
      PartnerUpFormViewState();
}

class PartnerUpFormViewState extends State<PartnerUpFormView> {
  String noOfVisas = '1';
  String nationality = 'UAE';

  final List<String> noOfVisasList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  final List<String> nationalityList = [
    'Pakistani',
    'UAE',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Corporate Form",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company Name",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              TextFieldWidget(
                hintText: "Enter Company name",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
              ),
              30.verticalSpace,

              Text(
                "Email ID",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              TextFieldWidget(
                hintText: "Enter email",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
              ),
              30.verticalSpace,
              Text(
                "Contact Number",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              SignupPhoneNumberField(
                controller: TextEditingController(),
                label: 'Phone Number',
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
              ),
              30.verticalSpace,
              Text(
                "Any Querry",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              TextFieldWidget(
                hintText: "Type here...",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
                maxLines: 6,
              ),
              30.verticalSpace,
              ButtonWidget(
                title: "Apply Now",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassportProSuccessView(),
                    ),
                  );
                },
                height: 48.h,
                width: 1.sw,
                borderRadius: 30,
                buttonColor: AppColors.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
