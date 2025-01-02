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
      markerId: MarkerId('Initial Camera Position'),
      position: LatLng(23.123, 21.234),
      infoWindow: InfoWindow(title: 'Initial Camera Position'),
    ),
    Marker(
      markerId: MarkerId('China'),
      infoWindow: InfoWindow(
        title: 'China',
      ),
      position: LatLng(38.7946, 106.5348),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _mapController.future;

          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(38.7946, 106.5348),
              ),
            ),
          );
        },
        child: Icon(
          Icons.room_preferences_sharp,
        ),
      ),
    );
  }
}
