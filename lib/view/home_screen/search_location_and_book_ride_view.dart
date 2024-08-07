import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/loading_widget.dart';
import 'package:royal_falcon/view_model/search_location_book_ride_view_model.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class SearchLocationAndBookRideView extends StatefulWidget {
  const SearchLocationAndBookRideView({
    super.key,
  });

  @override
  State<SearchLocationAndBookRideView> createState() =>
      _SearchLocationAndBookRideViewState();
}

class _SearchLocationAndBookRideViewState
    extends State<SearchLocationAndBookRideView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => SearchLocationBookRideViewModel(),
        child: Consumer<SearchLocationBookRideViewModel>(
          builder: (BuildContext context, model, Widget? child) => SafeArea(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              child: model.currentPosition == null
                  ? LoadingWidget(
                      color: AppColors.kPrimaryColor,
                    )
                  : Stack(
                      children: [
                        GoogleMap(
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          onMapCreated: (controller) {
                            model.mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              model.currentLatitude!,
                              model.currentLongitude!,
                            ),
                            zoom: 14,
                          ),
                          markers: model.markers,
                          polylines: model.polyLines,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 20,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              children: [
                                SearchMapPlaceWidget(
                                  hasClearButton: true,
                                  iconColor: AppColors.kPrimaryColor,
                                  placeType: PlaceType.address,
                                  bgColor: Color(0xFF1C1F23),
                                  textColor: Colors.grey,
                                  placeholder: model.currentAddress == null
                                      ? "Search pickup location"
                                      : model.currentAddress!,
                                  apiKey: model.googleMapApiKey,
                                  onSelected: (Place place) async {
                                    Geolocation? pickUpLocation =
                                        await place.geolocation;
                                    print(pickUpLocation?.coordinates.latitude);
                                    print(
                                        pickUpLocation?.coordinates.longitude);
                                    print(place.description);
                                    model.currentLatitude =
                                        pickUpLocation?.coordinates.latitude;
                                    model.currentLongitude =
                                        pickUpLocation?.coordinates.longitude;
                                    model.animateCameraToPosition(
                                        pickUpLocation?.coordinates);
                                    model.addMarker(pickUpLocation?.coordinates,
                                        "PickUp Location");
                                    if (model.dropOffLatitude != null ||
                                        model.dropOffLongitude != null) {
                                      // model.addPolyline(
                                      //     LatLng(model.currentLatitude!,
                                      //         model.currentLongitude!),
                                      //     LatLng(model.dropOffLatitude!,
                                      //         model.dropOffLongitude!));
                                      model.getPolyLinePoints(
                                          model.currentLatitude!,
                                          model.currentLongitude!,
                                          model.dropOffLatitude!,
                                          model.dropOffLongitude!);
                                      model.zoomOutToFitPolyline();
                                    }
                                    setState(() {});
                                  },
                                ),
                                20.verticalSpace,
                                SearchMapPlaceWidget(
                                  hasClearButton: true,
                                  iconColor: AppColors.kPrimaryColor,
                                  placeType: PlaceType.address,
                                  bgColor: Color(0xFF1C1F23),
                                  textColor: Colors.grey,
                                  placeholder: "Search dropoff location",
                                  apiKey: model.googleMapApiKey,
                                  onSelected: (Place place) async {
                                    Geolocation? pickUpLocation =
                                        await place.geolocation;
                                    model.dropOffLatitude =
                                        pickUpLocation?.coordinates.latitude;
                                    model.dropOffLongitude =
                                        pickUpLocation?.coordinates.longitude;
                                    model.addMarker(
                                      pickUpLocation?.coordinates,
                                      "DropOff Location",
                                    );
                                    // if (model.currentLatitude != null ||
                                    //     model.currentLongitude != null) {
                                      model.getPolyLinePoints(
                                          model.currentLatitude!,
                                          model.currentLongitude!,
                                          model.dropOffLatitude!,
                                          model.dropOffLongitude!);
                                      // model.addPolyline(
                                      //     LatLng(model.currentLatitude!,
                                      //         model.currentLongitude!),
                                      //     LatLng(model.dropOffLatitude!,
                                      //         model.dropOffLongitude!));
                                      model.zoomOutToFitPolyline();
                                    // }
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
