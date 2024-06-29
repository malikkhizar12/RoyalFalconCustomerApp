import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/view/rides/rides_widgets/form_text_field.dart';
import 'package:royal_falcon/view_model/rides_booking_form_view_model.dart';

import '../widgets/appbarcustom.dart';
import '../widgets/map_view.dart';

class RidesBookingForm extends StatefulWidget {
  final double price;
  final bool isFromAirportBooking;

  const RidesBookingForm(
      {Key? key, required this.price, this.isFromAirportBooking = false})
      : super(key: key);

  @override
  _RidesBookingFormState createState() => _RidesBookingFormState();
}

class _RidesBookingFormState extends State<RidesBookingForm> {
  TextEditingController _pickupLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RidesBookingFormViewModel(context),
      child: Consumer<RidesBookingFormViewModel>(
        builder: (BuildContext context, model, Widget? child) => Scaffold(
          backgroundColor: const Color(0xFF1C1F23),
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              SizedBox(height: 15.h),
              const AppbarCustom(title: "Booking"),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, right: 16.0, left: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: FormTextField(
                                    label: "No. of Passengers:",
                                    hint: '02',
                                    mandatory: true)),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: FormTextField(
                                    label: "No. of Bags",
                                    hint: '03',
                                    mandatory: true)),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                                child: FormTextField(
                                    label: "Pickup time:",
                                    hint: '3 June 10:30 AM',
                                    mandatory: true)),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: FormTextField(
                                label: "Pickup location:",
                                hint: 'Select location',
                                mandatory: true,
                                readOnly: true,
                                onTap: () async {
                                  // Navigate to Google Maps screen
                                  final selectedLocation = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapsScreen()),
                                  );

                                  if (selectedLocation != null) {
                                    setState(() {
                                      _pickupLocationController.text =
                                          selectedLocation;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: FormTextField(
                                label: "Flight no:",
                                hint: '1223432332',
                                mandatory: widget.isFromAirportBooking,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: FormTextField(
                                    label: "Drop off location:",
                                    hint: 'Building 1..',
                                    mandatory: true)),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                                child: FormTextField(
                                    label: "Special Request:",
                                    hint: '03 Adult / 01 Child',
                                    mandatory: true)),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          padding: EdgeInsets.all(16.h),
                          margin: EdgeInsets.only(top: 16.h),
                          decoration: const BoxDecoration(
                            color: Color(0xFF333639),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: buildSummarySection(context,(){
                            model.makePayment();
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummarySection(BuildContext context,onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Distance",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "26.7km",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Possible time",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "10 minutes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 26.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Cost",
              style: TextStyle(
                color: const Color(0xFFFFBC07),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.price} AED",
              style: TextStyle(
                color: const Color(0xFFFFBC07),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 26.h),
        Center(
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFBC07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 10.h,
              ),
            ),
            child: Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
