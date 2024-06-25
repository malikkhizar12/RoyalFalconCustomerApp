// maps_view_model.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config/config.dart';
import '../model/map_model.dart';

class MapsViewModel extends ChangeNotifier {
  late MapsModel _model;

  MapsViewModel() {
    _model = MapsModel();
  }

  LatLng get initialPosition => _model.initialPosition;
  Set<Marker> get markers => _model.markers;

  void addMarker(LatLng position, String title, String snippet) {
    _model.markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: title,
          snippet: snippet,
        ),
      ),
    );
    notifyListeners();
  }

  String get googleMapsApiKey => Config.googleMapsApiKey; // Get API key from config.dart
}
