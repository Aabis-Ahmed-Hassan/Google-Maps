import 'package:flutter/material.dart';
import 'package:google_maps_app/custom_marker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomMarker(),
    );
  }
}
