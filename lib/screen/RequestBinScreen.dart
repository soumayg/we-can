import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:wecann/resources/constants.dart';
import 'package:http/http.dart' as http;

class RequestBin extends StatelessWidget {
  static String id = 'requestBin';
  late MapmyIndiaMapController mapController;

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "images/locationIcon.png");
    mapController.addSymbol(SymbolOptions(
      geometry: LatLng(kLatitude, kLongitude),
      iconImage: "icon",
      iconSize: 0.07,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Bin'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: MapmyIndiaMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(kLatitude, kLongitude),
                    zoom: 21.0,
                  ),
                  onMapCreated: (map) async => {
                    mapController = map,
                  },
                  onStyleLoadedCallback: () => {addMarker()},
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Request has been sent for a smart trash can your current location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text('Latitide : ${kLatitude}'),
                  Text('Longitude : ${kLongitude}'),
                  Text('Place: ${kLocationName}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> postRequest() async {
  final userRegister = await http.post(
      Uri.parse('${baseUrl}/user/${kUsername}/can/request'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "lat": kLatitude.toString(),
        "lng": kLongitude.toString()
      }));
}
