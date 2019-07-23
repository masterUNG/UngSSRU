import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  // Explicit
  static const LatLng ssruLatLng = const LatLng(13.777651, 100.508871);
  CameraPosition cameraPosition = CameraPosition(
    target: ssruLatLng,
    zoom: 16.0,
  );

  // Method
  Widget showMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMap();
  }
}
