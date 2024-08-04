import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_falcon/utils/colors.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng _selectedLocation = LatLng(24.4539, 54.3773);
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, _selectedLocation.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Location",
          style: TextStyle(fontSize: 18.sp, color: AppColors.kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.kWhiteColor,
        // actions: [
        //   TextButton(
        //     onPressed: _confirmLocation,
        //     child: Text(
        //       "CONFIRM",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          fit: StackFit.loose,
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(_selectedLocation.toString()),
                  position: _selectedLocation,
                  infoWindow: InfoWindow(title: "My Location"),
                ),
              },
              onTap: _onTap,
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.buttonColor),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 60.h)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
