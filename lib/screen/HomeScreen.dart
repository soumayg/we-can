import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:wecann/screen/DepositBin.dart';
import 'package:wecann/screen/ReportBin.dart';
import 'package:wecann/screen/RequestBinScreen.dart';
import 'LeadershipBoardScreen.dart';
import 'package:wecann/resources/constants.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:wecann/resources/LocationService.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MapmyIndiaMapController mapController;
  LocationService locationService = new LocationService();
  late Symbol symbol;
  late String result = '';

  Future _scanQR(String page) async {
    await Permission.camera.request();
    try {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        result = cameraScanResult.toString();
        if (result != "null") {
          kQrResult = result;
          if (page == ReportBin.id)
            Navigator.pushNamed(context, ReportBin.id);
          else if (page == Deposit.id){
            postDeposit();
            Navigator.pushNamed(context, Deposit.id);
            setState(() {});
          }

        }
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We-Can ${kUsername}'),
        backgroundColor: Colors.orange,
      ),
      drawer: SafeArea(
        child: Container(
          color: Colors.white,
          width: 240.0,
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 100.0,
                color: Colors.blue,
              ),
              Text(
                kUsername,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 7.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {},
                    ),
                    Text('${kLocationName}')
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.score),
                      onPressed: () {
                        Navigator.pushNamed(context, LeadershipBoard.id);
                      },
                    ),
                    Text(points.toString())
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 7.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {},
                    ),
                    Text('Settings')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: MapmyIndiaMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(kLatitude, kLongitude),
                    zoom: 14.0,
                  ),
                  onMapCreated: (map) async => {
                    mapController = map,
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.orange,
                    child: TextButton(
                      onPressed: () async{
                        _scanQR(deposit);
                        await postDeposit();
                      },
                      child: Text(
                        deposit,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        locationService.getLocation();
                        postRequest();
                        Navigator.pushNamed(context, RequestBin.id);
                      },
                      child: Text(
                        'Request Bin',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
