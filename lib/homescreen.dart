import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Completer<GoogleMapController> _mapController = Completer();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(23.123, 21.234), zoom: 5);

  List<Marker> markers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(23.123, 21.234),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(23.124, 21.134),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _cameraPosition,
          markers: Set.of(markers),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          }),
    );
  }
}
