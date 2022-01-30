import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'constants.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class LocationService{
  late String accessToken = '';

  Future<void> getLatitudeAndLongitude() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    kLatitude = position.latitude;
    kLongitude = position.longitude;
  }

  Future<void> getLocationMapMyIndia() async {
    var response = await http.post(
      Uri.parse('https://outpost.mapmyindia.com/api/security/oauth/token?$kGrantType\&client_id=$kClientId\&client_secret=$kClientSecret'),
    );
    accessToken = jsonDecode(response.body.toString())['access_token'];
    MapmyIndiaAccountManager.setMapSDKKey(accessToken);
    MapmyIndiaAccountManager.setRestAPIKey(kMapMyIndiaRestApiKey);
    MapmyIndiaAccountManager.setAtlasClientId(kClientId);
    MapmyIndiaAccountManager.setAtlasClientSecret(kClientSecret);
  }


  Future<void> getLocation() async{
    await Permission.locationWhenInUse.request();
    await getLatitudeAndLongitude();
    await getLocationMapMyIndia();
    var url = Uri.parse('https://apis.mapmyindia.com/advancedmaps/v1/${kMapMyIndiaRestApiKey}/rev_geocode?lng=${kLongitude}&lat=${kLatitude}');
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200){
      String locationDetails = response.body.toString();
      kLocationName = jsonDecode(locationDetails)['results'][0]['subDistrict'];
      print(kLocationName);
    }
    print(response.statusCode);
  }

}