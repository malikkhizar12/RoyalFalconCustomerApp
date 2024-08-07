import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  void getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLatitude = currentPosition?.latitude;
    currentLongitude = currentPosition?.longitude;
    notifyListeners();
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

  void addPolyline(LatLng start, LatLng end) {
    final polyline = Polyline(
      polylineId: PolylineId("polyline"),
      points: [start, end],
      color: AppColors.kBlackColor,
      width: 5,
    );
    polyLines.add(polyline);
    print(polyLines.length);
    notifyListeners();
  }

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
