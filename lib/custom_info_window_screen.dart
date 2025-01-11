import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowScreen extends StatefulWidget {
  const CustomInfoWindowScreen({super.key});

  @override
  State<CustomInfoWindowScreen> createState() => _CustomInfoWindowScreenState();
}

class _CustomInfoWindowScreenState extends State<CustomInfoWindowScreen> {
  List<LatLng> locations = [
    LatLng(37.7750, -122.4193), // Slightly northeast
    LatLng(37.7748, -122.4195), // Slightly southwest
    LatLng(37.7751, -122.4196), // Slightly northwest
    LatLng(37.7747, -122.4192), // Slightly southeast
    LatLng(37.7750, -122.4195), // Very close northeast
    LatLng(37.7748, -122.4193), // Very close southwest
  ];

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  List<Marker> markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    for (var i = 0; i < 6; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('$i'),
          position: locations[i],

          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://fiverr-res.cloudinary.com/t_profile_original,q_auto,f_auto/attachments/profile/photo/8c45d8fce4874004f6d1fc773a34c750-1662120284709/129390b1-91dd-48cc-a076-9265f7a41c38.png'),
                    ),
                    Text(
                      'My Location $i',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              locations[i],
            );
          },
          // infoWindow: InfoWindow(
          //   title: 'Location $i',
          // ),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              markers = [];
              loadData();
              setState(() {});
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7750, -122.4193),
              zoom: 20,
            ),
            markers: Set.of(markers),
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (LatLng latLng) {
              _customInfoWindowController.hideInfoWindow!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            // height: 200,
            // width: 100,
            offset: 10,
          ),
        ],
      ),
    );
  }
}
