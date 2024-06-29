import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:royal_falcon/view/rides/rides_widgets/form_text_field.dart';
import 'package:royal_falcon/view_model/rides_booking_form_view_model.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../widgets/appbarcustom.dart';

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
  bool isFromAirportBooking = false; // Track the selected booking type

  // Controllers for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();
  final TextEditingController bagsController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController flightNoController = TextEditingController();
  final TextEditingController specialRequestController =
      TextEditingController();

  DateTime? selectedDateTime;
  double? pickUpLatitude, pickUpLongitude, dropOffLatitude, dropOffLongitude;
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;

  @override
  void initState() {
    super.initState();
    // Initialize booking type based on widget's initial value
    isFromAirportBooking = widget.isFromAirportBooking;
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    passengersController.dispose();
    bagsController.dispose();
    pickupTimeController.dispose();
    contactNumberController.dispose();
    flightNoController.dispose();
    specialRequestController.dispose();
    super.dispose();
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(Duration(days: 365)), // Allow selection for one year from now
      // Customize date picker colors
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07), // Customize primary color
              onPrimary: Colors.black, // Customize text color on primary color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
        // Customize time picker colors
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: const Color(0xFFFFBC07), // Customize primary color
                onPrimary:
                    Colors.black, // Customize text color on primary color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          pickupTimeController.text = DateFormat.yMd()
              .add_jm()
              .format(selectedDateTime!); // Format date and time
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          RidesBookingFormViewModel(context, widget.price),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          label: "Name",
                          hint: 'XYZ',
                          mandatory: true,
                          controller: nameController,
                        ),
                        SizedBox(height: 16.h),
                        FormTextField(
                          label: "Email",
                          hint: 'xyz@gmail.com',
                          mandatory: true,
                          controller: emailController,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Booking Type: ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 8.w),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    height: 60.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<bool>(
                                        value: isFromAirportBooking,
                                        onChanged: (newValue) {
                                          setState(() {
                                            isFromAirportBooking = newValue!;
                                          });
                                        },
                                        dropdownColor: Color(0xFF1C1F23),
                                        items: [
                                          DropdownMenuItem<bool>(
                                            value: false,
                                            child: Text(
                                              'Normal Booking',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DropdownMenuItem<bool>(
                                            value: true,
                                            child: Text(
                                              'Airport Booking',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: FormTextField(
                                label: "City",
                                hint: 'Pickup City',
                                mandatory: true,
                                controller: TextEditingController(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: FormTextField(
                                label: "No. of Passengers:",
                                hint: '02',
                                mandatory: true,
                                controller: passengersController,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: FormTextField(
                                label: "No. of Bags",
                                hint: '03',
                                mandatory: true,
                                controller: bagsController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _selectDateAndTime(
                                      context); // Call function to show combined date-time picker
                                },
                                child: AbsorbPointer(
                                  child: FormTextField(
                                    label: "Pickup time:",
                                    hint: 'Select Date and Time',
                                    mandatory: true,
                                    controller: pickupTimeController,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: FormTextField(
                                label: "Contact Number",
                                hint: '+971********',
                                mandatory: true,
                                controller: contactNumberController,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 16.h),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: LocationInput(
                        //         mandatory: true,
                        //         name: "pickupLocation",
                        //         labelTitle: "Pickup location:",
                        //         labelStyle: TextStyle(
                        //             color: Colors.white, fontSize: 16),
                        //         inputStyle: InputDecoration(
                        //           hintText: 'Select location',
                        //           hintStyle: TextStyle(color: Colors.grey),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0xFFFFBC07)),
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //         ),
                        //         containerStyle: BoxDecoration(),
                        //         isPickup: true,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Text(
                              "Pickup location:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                color: Color(0xFFFFBC07),
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 1.sw,
                          // height: 65.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: SearchMapPlaceWidget(
                              hasClearButton: true,
                              iconColor: Colors.grey,
                              placeType: PlaceType.address,
                              bgColor: Color(0xFF1C1F23),
                              textColor: Colors.grey,
                              placeholder: "Search Location",
                              apiKey: googleMapApiKey,
                              onSelected: (Place place) async {
                                Geolocation? pickUpLocation =
                                    await place.geolocation;
                                print(pickUpLocation!.coordinates);
                                pickUpLatitude =
                                    pickUpLocation.coordinates.latitude;
                                pickUpLongitude =
                                    pickUpLocation.coordinates.longitude;
                                if (dropOffLatitude != null ||
                                    dropOffLongitude != null) {
                                  model.getTravelTime(
                                      pickUpLatitude!,
                                      pickUpLongitude!,
                                      dropOffLatitude!,
                                      dropOffLongitude!);
                                }
                              }),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Text(
                              "Drop off location:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                color: Color(0xFFFFBC07),
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 1.sw,
                          // height: 65.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: SearchMapPlaceWidget(
                              hasClearButton: true,
                              iconColor: Colors.grey,
                              placeType: PlaceType.address,
                              bgColor: Color(0xFF1C1F23),
                              textColor: Colors.grey,
                              placeholder: "Search Location",
                              apiKey: googleMapApiKey,
                              onSelected: (Place place) async {
                                Geolocation? dropOffLocation =
                                    await place.geolocation;
                                print(dropOffLocation!.coordinates);
                                dropOffLatitude =
                                    dropOffLocation.coordinates.latitude;
                                dropOffLongitude =
                                    dropOffLocation.coordinates.longitude;
                                if (pickUpLatitude != null ||
                                    pickUpLongitude != null) {
                                  model.getTravelTime(
                                      pickUpLatitude!,
                                      pickUpLongitude!,
                                      dropOffLatitude!,
                                      dropOffLongitude!);
                                }
                              }),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: LocationInput(
                        //         mandatory: true,
                        //         name: "dropoffLocation",
                        //         labelTitle: "Drop off location:",
                        //         labelStyle: TextStyle(
                        //             color: Colors.white, fontSize: 16),
                        //         inputStyle: InputDecoration(
                        //           hintText: 'Select location',
                        //           hintStyle: TextStyle(color: Colors.grey),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide:
                        //                 BorderSide(color: Color(0xFFFFBC07)),
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //         ),
                        //         containerStyle: BoxDecoration(),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: FormTextField(
                                label: "Special Request:",
                                hint: '03 Adult / 01 Child',
                                mandatory: true,
                                controller: specialRequestController,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Visibility(
                              visible:
                                  isFromAirportBooking, // Show flight number field only for airport booking
                              child: Expanded(
                                child: FormTextField(
                                  label: "Flight No:",
                                  hint: '1223432332',
                                  mandatory: isFromAirportBooking,
                                  controller: flightNoController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: double.infinity,
                          padding: EdgeInsets.all(16.h),
                          margin: EdgeInsets.only(top: 16.h),
                          decoration: const BoxDecoration(
                            color: Color(0xFF333639),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: buildSummarySection(
                              context,
                              model.distanceInKm.toString(),
                              model.possibleTime.toString(), () {
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

  Widget buildSummarySection(
      BuildContext context, String distanceValue, String possibleTime, onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  "$distanceValue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Possible time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$possibleTime",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
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
