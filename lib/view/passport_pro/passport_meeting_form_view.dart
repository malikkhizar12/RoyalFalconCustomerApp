import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/passport_pro/passport_pro_success_view.dart';
import 'package:royal_falcon/view/signup/widgets/phone_number_field.dart';
import 'package:royal_falcon/view/widgets/app_bar_widget.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
import 'package:royal_falcon/view/widgets/textfield_widget.dart';

class PassportMeetingFormView extends StatefulWidget {
  const PassportMeetingFormView({super.key});

  @override
  State<PassportMeetingFormView> createState() =>
      _PassportMeetingFormViewState();
}

class _PassportMeetingFormViewState extends State<PassportMeetingFormView> {
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
        title: "Meeting Form",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Full Name",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              TextFieldWidget(
                hintText: "Enter full name",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
              ),
              30.verticalSpace,
              Text(
                "Passport Number",
                style: TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              10.verticalSpace,
              TextFieldWidget(
                hintText: "Enter passport number",
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No of Visas",
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE0E0E0),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.kWhiteColor,
                            value: noOfVisas,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: AppColors.kBlackColor,
                            ),
                            isExpanded: true,
                            items: noOfVisasList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                noOfVisas = newValue!;
                              });
                            },
                            underline: Container(), // Remove underline
                          ),
                        ),
                      ],
                    ),
                  ),
                  35.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nationality",
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE0E0E0),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.kWhiteColor,
                            value: nationality,
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: AppColors.kBlackColor,
                            ),
                            isExpanded: true,
                            items: nationalityList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                nationality = newValue!;
                              });
                            },
                            underline: Container(), // Remove underline
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Text(
                "Contact Number With Country Code",
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
              TextFieldWidget(
                hintText: "Type here...",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                isShadow: false,
                backgroundColor: const Color(0xffE0E0E0),
                borderRadius: 4,
                maxLines: 5,
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
