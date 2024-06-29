import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/map_view_model.dart';


class LocationInput extends StatefulWidget {
  final String name;
  final String labelTitle;
  final bool mandatory;

  final TextStyle labelStyle;
  final InputDecoration inputStyle;
  final BoxDecoration containerStyle;
  final bool readOnly;
  final bool isPickup;
  final String selectedCity;

  LocationInput({
    Key? key,
    required this.name,
    required this.labelTitle,
    required this.labelStyle,
    required this.inputStyle,
    required this.containerStyle,
    this.readOnly = false,
    this.isPickup = false,
    this.selectedCity = 'Dubai',
    required this.mandatory,
  }) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mapsViewModel = Provider.of<MapsViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.labelTitle,
              style:  TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            if (widget.mandatory)
              Text(
                ' *',
                style: TextStyle(
                  color: Color(0xFFFFBC07),
                  fontSize: 16.sp,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.0),
        // GestureDetector(
        //   onTap: widget.readOnly ? null : () async {
        //     Prediction? p = await PlacesAutocomplete.show(
        //       context: context,
        //       apiKey: mapsViewModel.googleMapsApiKey,
        //       mode: Mode.overlay,
        //       language: "en",
        //       components: [
        //         Component(Component.country, "ae"),
        //         if (widget.selectedCity == 'Dubai')
        //           Component(Component.administrativeArea, "Dubai")
        //         else if (widget.selectedCity == 'Abu Dhabi')
        //           Component(Component.administrativeArea, "Abu Dhabi"),
        //       ],
        //     );
        //     if (p != null) {
        //       GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: mapsViewModel.googleMapsApiKey);
        //       PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
        //       setState(() {
        //         _locationController.text = detail.result.formattedAddress!;
        //       });
        //     }
        //   },
        //   child: AbsorbPointer(
        //     child: SizedBox(height: 60.h,
        //       child: TextField(
        //         controller: _locationController,
        //         decoration: widget.inputStyle.copyWith(
        //           hintText: 'Select location',
        //           suffixIcon: Icon(Icons.location_on),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
