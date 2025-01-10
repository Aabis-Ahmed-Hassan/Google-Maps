import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'apiKey.dart';

class LocationSuggestion extends StatefulWidget {
  const LocationSuggestion({super.key});

  @override
  State<LocationSuggestion> createState() => _LocationSuggestionState();
}

class _LocationSuggestionState extends State<LocationSuggestion> {
  TextEditingController _controller = TextEditingController();

  String? token;

  List<dynamic> places = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (token == null) {
      var uuid = Uuid().v4();
      token = uuid;
      setState(() {});
    }

    hitApi(_controller.text.toString());
  }

  void hitApi(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String apiUrl = '$baseURL?input=$input&key=$apiKey&sessiontoken=$token';

    http.Response response = await http.get(Uri.parse(apiUrl));
    // print(jsonDecode(response.body.toString()));
    // success
    if (response.statusCode == 200) {
      setState(() {
        places = jsonDecode(response.body.toString())['predictions'];
      });
    }
    //   fail
    else {
      print('aabis');
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(10),
          color: Colors.red,
          child: TextField(
            controller: _controller,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () async {
                      List<Location> locations = await GeocodingPlatform
                          .instance!
                          .locationFromAddress(places[index]['description']);
                      print('\n\n\n\n\n');
                      print('longitude: ${locations[0].longitude}');
                      print('latitude: ${locations[0].latitude}');
                      print('\n\n\n\n\n');
                    },
                    child: ListTile(
                      title: Text(places[index]['description']),
                    ),
                  ),
                );
              }),
        ),
      ],
    ));
  }
}
