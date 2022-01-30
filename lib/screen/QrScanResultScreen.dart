import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:wecann/resources/constants.dart';

class QrResult extends StatelessWidget {
  static String id = 'qrResult';
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
        title: Text('We-Can Develop'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text('Congratulations ${kUsername}', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27.0,),),
                  SizedBox(
                    height: 21.0,
                    width: double.infinity,
                  ),
                  Text('You\'ve earned 1 point'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
