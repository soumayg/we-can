import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:wecann/resources/constants.dart';
import 'package:http/http.dart' as http;

class ReportBin extends StatelessWidget {
  static String id = reportBin;
  late MapmyIndiaMapController mapController;

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "images/icon.png");
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
        title: Text('We-Can Clean'),
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
            Text('Bin reported for maintenance work',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}

Future<void> postReport() async {
  final userRegister = await http.post(Uri.parse('${baseUrl}/can/${kQrResult}/user/${kUsername}/report'));
}
