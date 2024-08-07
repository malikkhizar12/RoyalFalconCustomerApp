import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:royal_falcon/utils/colors.dart';
import 'package:royal_falcon/view/widgets/button_widget.dart';
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
                          zoomControlsEnabled: true,
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
                          onTap: (LatLng position) async {
                            if (model.isSelectingPickup) {
                              model.currentLatitude = position.latitude;
                              model.currentLongitude = position.longitude;
                              model.addMarker(position, "PickUp Location");
                              model.isSelectingPickup = false;
                            } else {
                              model.dropOffLatitude = position.latitude;
                              model.dropOffLongitude = position.longitude;
                              model.addMarker(position, "DropOff Location");
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
                                  bgColor: AppColors.backgroundColor,
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
                                  bgColor: AppColors.backgroundColor,
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
                        DraggableScrollableSheet(
                          initialChildSize: model.isExpanded ? 0.4 : 0.2,
                          minChildSize: model.isExpanded ? 0.4 : 0.2,
                          maxChildSize: model.isExpanded ? 0.5 : 0.2,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Container(
                              color: AppColors.cardBackground,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.h),
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Container(
                                    width: 1.sw,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: AppColors.backgroundColor),
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Text(
                                      "Time",
                                      style: TextStyle(
                                        color: AppColors.kWhiteColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  20.verticalSpace,
                                  ButtonWidget(
                                    title: model.isExpanded
                                        ? "Change Location"
                                        : "Confirm Location",
                                    onTap: model.toggleSheet,
                                    borderRadius: 5,
                                  ),
                                  if (model.isExpanded) ...[
                                    20.verticalSpace,
                                    Container(
                                      height: 200.h,
                                      width: 1.sw,
                                      color: AppColors.kBlackColor,
                                      child: Center(
                                        child: Text(
                                          'Cars Listview',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Add more widgets here for the content inside the draggable sheet
                                  ],
                                ],
                              ),
                            );
                          },
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
