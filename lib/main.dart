import 'package:flutter/material.dart';
import 'package:google_maps_app/animate_camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimateCamera(),
    );
  }
}
