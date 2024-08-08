import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_falcon/utils/colors.dart';

class SearchLocationBookRideViewModel extends ChangeNotifier {
  SearchLocationBookRideViewModel() {
    getCurrentLocation();
  }
  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;
  Position? currentPosition;
  double? currentLatitude, currentLongitude, dropOffLatitude, dropOffLongitude;
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  List<Placemark>? placeMarks;
  String? currentAddress, dropOffAddress;
  bool isExpanded = false;
  bool isSelectingPickup = true, isCarSelected = false;

  void toggleSheet() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  void getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    notifyListeners();
    currentLatitude = currentPosition?.latitude;
    currentLongitude = currentPosition?.longitude;
    currentAddress =
        await getLocationAddress(currentLatitude!, currentLongitude!);
    addMarker(LatLng(currentLatitude!, currentLongitude!), "PickUp Location");
    notifyListeners();
  }

  Future<String> getLocationAddress(latitude, longitude) async {
    placeMarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placeMarks![0];
    return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }

  void setCurrentPosition(Position position) {
    currentPosition = position;
    notifyListeners();
  }

  void animateCameraToPosition(LatLng latLng) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 14,
          // tilt: 45.0,
          bearing: 90.0,
        ),
      ),
    );
  }

  void addMarker(LatLng latLng, String title) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: latLng,
      infoWindow: InfoWindow(title: title),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    markers.add(marker);
    notifyListeners();
  }

  Future<void> getPolyLinePoints(curLat, curLong, desLat, desLong) async {
    List<LatLng> polyCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(curLat, curLong),
      PointLatLng(desLat, desLong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        polyCoordinates.add(LatLng(element.latitude, element.longitude));
        print(element);
      }
      addPolyline(polyCoordinates);
    } else {
      if (kDebugMode) {
        print("Error message : ${result.errorMessage}");
      }
    }
    // return polyCoordinates;
  }

  void addPolyline(List<LatLng> polyCoordinates) {
    final polyline = Polyline(
      polylineId: PolylineId("polyline"),
      points: polyCoordinates,
      color: AppColors.kBlackColor,
      width: 5,
    );
    polyLines.add(polyline);
    print(polyline);
    notifyListeners();
  }

  // void addPolyline(LatLng start, LatLng end) {
  //   final polyline = Polyline(
  //     polylineId: PolylineId("polyline"),
  //     points: [start, end],
  //     color: AppColors.kBlackColor,
  //     width: 5,
  //   );
  //   polyLines.add(polyline);
  //   print(polyLines.length);
  //   notifyListeners();
  // }

  void zoomOutToFitPolyline() {
    LatLngBounds bounds;
    if (currentLatitude! > dropOffLatitude! &&
        currentLongitude! > dropOffLongitude!) {
      bounds = LatLngBounds(
        southwest: LatLng(dropOffLatitude!, dropOffLongitude!),
        northeast: LatLng(currentLatitude!, currentLongitude!),
      );
    } else if (currentLongitude! > dropOffLongitude!) {
      bounds = LatLngBounds(
        southwest: LatLng(currentLatitude!, dropOffLongitude!),
        northeast: LatLng(dropOffLatitude!, currentLongitude!),
      );
    } else if (currentLatitude! > dropOffLatitude!) {
      bounds = LatLngBounds(
        southwest: LatLng(dropOffLatitude!, currentLongitude!),
        northeast: LatLng(currentLatitude!, dropOffLongitude!),
      );
    } else {
      bounds = LatLngBounds(
        southwest: LatLng(currentLatitude!, currentLongitude!),
        northeast: LatLng(dropOffLatitude!, dropOffLongitude!),
      );
    }
    mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}
