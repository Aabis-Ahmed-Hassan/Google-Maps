import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonsScreen extends StatefulWidget {
  const PolygonsScreen({super.key});

  @override
  State<PolygonsScreen> createState() => _PolygonsScreenState();
}

class _PolygonsScreenState extends State<PolygonsScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Polygon> polygonsSet = HashSet();
  List<LatLng> coordinates = [
    LatLng(32.920893, 72.407223),
    LatLng(32.923775, 72.431684),
    LatLng(32.934797, 72.422243),
    LatLng(32.935878, 72.400442),
    LatLng(32.920893, 72.407223),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    polygonsSet.add(
      Polygon(
        polygonId: PolygonId('1'),
        fillColor: Colors.red,
        points: coordinates,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            32.920893,
            72.407223,
          ),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        polygons: polygonsSet,
      ),
    );
  }
}
