import 'package:geolocator/geolocator.dart';

class LocationPermissionRequest {
  static Future<void> getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition();
      // setState(() {
      //   _initialCameraPosition = CameraPosition(
      //     target: LatLng(position.latitude, position.longitude),
      //     zoom: 13,
      //   );
      // });
      print("Current position: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      print("Error in getting location: $e");
    }
  }
}
