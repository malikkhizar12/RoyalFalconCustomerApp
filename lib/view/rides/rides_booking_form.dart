import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:royal_falcon/view/rides/rides_widgets/form_text_field.dart';
import 'package:royal_falcon/view_model/rides_booking_form_view_model.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../../utils/utils/utils.dart';
import '../widgets/appbarcustom.dart';
import '../widgets/build_summary_booking_section.dart';

class RidesBookingForm extends StatefulWidget {
  final double price;
  final String id;
  final bool isFromAirportBooking;

  const RidesBookingForm({
    Key? key,
    required this.price,
    required this.id,
    this.isFromAirportBooking = false,
  }) : super(key: key);

  @override
  _RidesBookingFormState createState() => _RidesBookingFormState();
}

class _RidesBookingFormState extends State<RidesBookingForm> {
  bool isFromAirportBooking = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();
  final TextEditingController bagsController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController flightNoController = TextEditingController();
  final TextEditingController flightTimeController = TextEditingController();
  final TextEditingController specialRequestController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add form key

  DateTime? selectedDateTime;
  DateTime? selectedFlightDateTime;
  double? pickUpLatitude, pickUpLongitude, dropOffLatitude, dropOffLongitude;
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;
  String pickupLocationName = '';
  String dropOffLocationName = '';

  @override
  void initState() {
    super.initState();
    isFromAirportBooking = widget.isFromAirportBooking;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passengersController.dispose();
    bagsController.dispose();
    pickupTimeController.dispose();
    contactNumberController.dispose();
    flightNoController.dispose();
    flightTimeController.dispose();
    specialRequestController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07),
              onPrimary: Colors.black,
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
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: const Color(0xFFFFBC07),
                onPrimary: Colors.black,
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
          pickupTimeController.text =
              DateFormat.yMd().add_jm().format(selectedDateTime!);
        });
      }
    }
  }

  Future<void> _selectFlightDateAndTime(BuildContext context) async {
    final DateTime? pickedFlightDateTime = await showDatePicker(
      context: context,
      initialDate: selectedFlightDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFFBC07),
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedFlightDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedFlightDateTime ?? DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: const Color(0xFFFFBC07),
                onPrimary: Colors.black,
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
          selectedFlightDateTime = DateTime(
            pickedFlightDateTime.year,
            pickedFlightDateTime.month,
            pickedFlightDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          flightTimeController.text =
              DateFormat.yMd().add_jm().format(selectedFlightDateTime!);
        });
      }
    }
  }

  void sendBookingData(BuildContext context) {
    bool isValid = true;
    String errorMessage = '';

    if (nameController.text.isEmpty) {
      isValid = false;
      errorMessage = 'Name is required.';
    } else if (emailController.text.isEmpty ||
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      isValid = false;
      errorMessage = 'Valid email is required.';
    } else if (passengersController.text.isEmpty || int.tryParse(passengersController.text) == null) {
      isValid = false;
      errorMessage = 'Number of passengers is required.';
    } else if (bagsController.text.isEmpty || int.tryParse(bagsController.text) == null) {
      isValid = false;
      errorMessage = 'Number of bags is required.';
    } else if (pickupTimeController.text.isEmpty) {
      isValid = false;
      errorMessage = 'Pickup time is required.';
    } else if (contactNumberController.text.isEmpty || !RegExp(r'^\+?[0-9]{10,13}$').hasMatch(contactNumberController.text)) {
      isValid = false;
      errorMessage = 'Valid contact number is required.';
    } else if (cityController.text.isEmpty) {
      isValid = false;
      errorMessage = 'City is required.';
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      return;
    }

    final String name = nameController.text;
    final vehicleId = widget.id;
    final String email = emailController.text;
    final int passengers = int.tryParse(passengersController.text) ?? 0;
    final int bags = int.tryParse(bagsController.text) ?? 0;
    final String contactNumber = contactNumberController.text;
    final String specialRequest = specialRequestController.text;
    final String city = cityController.text;

    final String pickupTime = pickupTimeController.text;
    DateTime pickupDateTime;
    try {
      final cleanedPickupTime = pickupTime.replaceAll('\u202F', ' ');
      pickupDateTime = DateFormat('M/d/yyyy h:mm a').parse(cleanedPickupTime);
    } catch (e) {
      print('Error parsing date: $e');
      Utils.errorMessage("Invalid date format", context);
      return;
    }
    String formattedPickupDateTime =
    DateFormat('yyyy-MM-ddTHH:mm').format(pickupDateTime);

    final Map<String, dynamic> bookingData = {
      'city': city,
      'bookingType': isFromAirportBooking ? 'airport' : 'normal',
      'name': name,
      'email': email,
      'specialRequest': specialRequest,
      'contactNumber': contactNumber,
      'noOfpeople': passengers,
      'noOfBaggage': bags,
      'pickUpDateTime': formattedPickupDateTime,
      'fromLat': pickUpLatitude,
      'fromLong': pickUpLongitude,
      'toLat': dropOffLatitude,
      'toLong': dropOffLongitude,
      'fromLocationName': pickupLocationName,
      'toLocationName': dropOffLocationName,
      'vehicleCategoryId': vehicleId,
      'bookingAmount': widget.price
    };

    if (isFromAirportBooking) {
      bookingData['flightNo'] = flightNoController.text;
      bookingData['flightTiming'] = flightTimeController.text;
    }

    Provider.of<RidesBookingFormViewModel>(context, listen: false)
        .createBooking(bookingData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          RidesBookingFormViewModel(context, widget.price),
      child: Consumer<RidesBookingFormViewModel>(
        builder: (BuildContext context, model, Widget? child) => Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xFF1C1F23),
              resizeToAvoidBottomInset: true,
              body: Form(  // Wrap the form fields in a Form widget
                key: _formKey,
                child: Column(
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
                                controller: nameController,
                              ),
                              SizedBox(height: 16.h),
                              FormTextField(
                                label: "Email",
                                hint: 'xyz@gmail.com',
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
                                              color: Colors.white,
                                              fontSize: 16.sp),
                                        ),
                                        SizedBox(height: 8.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          height: 55.h,
                                          width: 0.47.sw, // Using 47% of screen width
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(15.r),
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
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              ),
                                              items: [
                                                DropdownMenuItem<bool>(
                                                  value: false,
                                                  child: Text(
                                                    'Normal Booking',
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                ),
                                                DropdownMenuItem<bool>(
                                                  value: true,
                                                  child: Text(
                                                    'Airport Booking',
                                                    style: TextStyle(color: Colors.grey),
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
                                      controller: cityController,
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
                                      controller: passengersController,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: FormTextField(
                                      label: "No. of Bags",
                                      hint: '03',
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
                                      controller: contactNumberController,
                                    ),
                                  ),
                                ],
                              ),
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                                    setState(() {
                                      pickUpLatitude =
                                          pickUpLocation?.coordinates.latitude;
                                      pickUpLongitude =
                                          pickUpLocation?.coordinates.longitude;
                                      pickupLocationName =
                                          place.description ?? '';
                                    });
                                    if (dropOffLatitude != null ||
                                        dropOffLongitude != null) {
                                      model.getTravelTime(
                                        pickUpLatitude!,
                                        pickUpLongitude!,
                                        dropOffLatitude!,
                                        dropOffLongitude!,
                                      );
                                    }
                                  },
                                ),
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                                      setState(() {
                                        dropOffLatitude =
                                            dropOffLocation?.coordinates.latitude;
                                        dropOffLongitude = dropOffLocation
                                            ?.coordinates.longitude;
                                        dropOffLocationName =
                                            place.description ?? '';
                                      });
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
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: FormTextField(
                                      label: "Special Request:",
                                      hint: '03 Adult / 01 Child',
                                      controller: specialRequestController,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Visibility(
                                    visible: isFromAirportBooking,
                                    child: Expanded(
                                      child: FormTextField(
                                        label: "Flight No:",
                                        hint: '1223432332',
                                        controller: flightNoController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Visibility(
                                visible: isFromAirportBooking,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectFlightDateAndTime(context);
                                        },
                                        child: AbsorbPointer(
                                          child: FormTextField(
                                            label: "Flight Time:",
                                            hint: 'Select Flight Date and Time',
                                            controller: flightTimeController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                  child: SummarySection(
                                    distanceValue: model.distanceInKm.toString(),
                                    possibleTime: model.possibleTime.toString(),
                                    onTap: () {
                                      sendBookingData(context);                                },
                                    isLoading: model.isLoading,
                                    price: widget.price, // Pass the price
                                  )
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
            if (model.isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFBC07),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


