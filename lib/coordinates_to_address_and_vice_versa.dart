import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordinatesToAddressAndViceVersa extends StatefulWidget {
  const CoordinatesToAddressAndViceVersa({super.key});

  @override
  State<CoordinatesToAddressAndViceVersa> createState() =>
      _CoordinatesToAddressAndViceVersaState();
}

class _CoordinatesToAddressAndViceVersaState
    extends State<CoordinatesToAddressAndViceVersa> {
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.6995, 73.0363),
    zoom: 5,
  );

  List<Marker> markers = [
    Marker(
      markerId: MarkerId(
        'Islamabad',
      ),
      infoWindow: InfoWindow(
        title: 'Islamabad',
      ),
      position: LatLng(33.6995, 73.0363),
    ),
  ];

  Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String result = 'No Address Found';
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (String address) async {
                await locationFromAddress(address)
                    .then((List<Location> locations) async {
                  GoogleMapController controller = await _completer.future;
                  await controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 15,
                        target: LatLng(
                            locations[0].latitude, locations[0].longitude),
                      ),
                    ),
                  );
                });
              },
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: _cameraPosition,
                markers: Set.of(markers),
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // List<Placemark> placemarks =
          //     await placemarkFromCoordinates(33.6995, 73.0363);
          // result = placemarks[0].country.toString();
          await locationFromAddress('Talagang, Pakistan')
              .then((List<Location> location) async {
            GoogleMapController controller = await _completer.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(location[0].latitude, location[0].longitude),
                    zoom: 13),
              ),
            );
          });
        },
        child: Text('Convert'),
      ),
    );
  }
}
