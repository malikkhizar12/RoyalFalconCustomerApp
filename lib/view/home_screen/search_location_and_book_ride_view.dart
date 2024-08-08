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
                              model.currentAddress =
                                  await model.getLocationAddress(
                                      position.latitude, position.longitude);
                              model.isSelectingPickup = false;
                            } else {
                              model.dropOffLatitude = position.latitude;
                              model.dropOffLongitude = position.longitude;
                              model.addMarker(position, "DropOff Location");
                              model.dropOffAddress =
                                  await model.getLocationAddress(
                                      position.latitude, position.longitude);
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
                                  placeholder: model.dropOffAddress == null
                                      ? "Search dropoff location"
                                      : model.dropOffAddress!,
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
                          initialChildSize: model.isCarSelected
                              ? 0.2
                              : model.isExpanded
                                  ? 0.5
                                  : 0.2,
                          minChildSize: model.isCarSelected
                              ? 0.2
                              : model.isExpanded
                                  ? 0.5
                                  : 0.2,
                          maxChildSize: model.isCarSelected
                              ? 0.2
                              : model.isExpanded
                                  ? 0.5
                                  : 0.2,
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
                                    title: model.isCarSelected
                                        ? "Book Car"
                                        : model.isExpanded
                                            ? "Change Location"
                                            : "Confirm Location",
                                    onTap: model.toggleSheet,
                                    borderRadius: 5,
                                  ),
                                  if (model.isExpanded) ...[
                                    20.verticalSpace,
                                    Text("Select Car Type"),
                                    20.verticalSpace,
                                    Container(
                                      height: 200.h,
                                      width: 1.sw,
                                      child: Center(
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                model.isCarSelected = true;
                                                model.isExpanded = false;
                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/car_image.png",
                                                    ),
                                                    10.verticalSpace,
                                                    Text("Car Image"),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: 6,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  20.horizontalSpace,
                                        ),
                                      ),
                                    ),
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