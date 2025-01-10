import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  CameraPosition _initialCameraPostion = CameraPosition(
    target: LatLng(
      37.7749,
      -122.4194,
    ),
    zoom: 20,
  );
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];
  List<LatLng> locations = [
    LatLng(37.7750, -122.4193), // Slightly northeast
    LatLng(37.7748, -122.4195), // Slightly southwest
    LatLng(37.7751, -122.4196), // Slightly northwest
    LatLng(37.7747, -122.4192), // Slightly southeast
    LatLng(37.7750, -122.4195), // Very close northeast
    LatLng(37.7748, -122.4193), // Very close southwest
  ];

  void loadData() async {
    for (var i = 0; i < 6; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('$i'),
          position: locations[i],
          infoWindow: InfoWindow(
            title: 'Location $i',
          ),
          // icon: BitmapDescriptor.bytes(
          //   await getBytesFromAsset(
          //     'assets/marker($i).png',
          //     100,
          //   ),
          // ),
          icon: BitmapDescriptor.bytes(
            await getBytesFromAsset(
              'assets/marker($i).png',
              30,
            ),
          ),
        ),
      );
      setState(() {});
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.add)),
          for (var i = 0; i < 6; i++)
            Image(image: AssetImage('assets/marker(0).png')),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPostion,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
