import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        title: Text("Select Location"),
        actions: [
          TextButton(
            onPressed: _confirmLocation,
            child: Text(
              "CONFIRM",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: GoogleMap(
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
    );
  }
}
