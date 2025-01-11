import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  List<LatLng> coordinates = [
    LatLng(32.920893, 72.407223),
    LatLng(32.923775, 72.431684),
    LatLng(32.934797, 72.422243),
    LatLng(32.935878, 72.400442),
  ];

  List<Marker> markers = [];

  Set<Polyline> polylineSet = HashSet();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < coordinates.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(
            '$i',
          ),
          infoWindow: InfoWindow(
            title: 'Marker $i',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
    }
    polylineSet.add(
      Polyline(
        polylineId: PolylineId('1'),
        points: coordinates,
        color: Colors.red.withValues(alpha: 0.3),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(32.920893, 72.407223),
          zoom: 14,
        ),
        markers: Set.of(markers),
        polylines: polylineSet,
      ),
    );
  }
}
