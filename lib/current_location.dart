import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(
        33.6995,
        73.0363,
      ),
      zoom: 15);
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        33.6995,
        73.0363,
      ),
      infoWindow: InfoWindow(
        title: 'Initial Camera Position',
      ),
    ),
  ];

  Future<Position> getCurrentLocation() async {
    Geolocator.requestPermission().then((e) {}).catchError((e) {
      print('error');
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapType: MapType.satellite,
        markers: Set.of(markers),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        getCurrentLocation().then((Position currentLocation) async {
          LatLng currentLatLng =
              LatLng(currentLocation.latitude, currentLocation.longitude);

          markers.add(
            Marker(
                markerId: MarkerId('2'),
                infoWindow: InfoWindow(title: 'Current Location'),
                position: currentLatLng),
          );
          GoogleMapController newController = await _controller.future;

          CameraPosition newCameraPosition =
              CameraPosition(target: currentLatLng, zoom: 14);
          newController
              .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
          setState(() {});
        });
      }),
    );
  }
}
