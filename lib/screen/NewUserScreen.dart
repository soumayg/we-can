import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'package:wecann/resources/LocationService.dart';
import 'package:wecann/resources/constants.dart';


class NewUser extends StatefulWidget {
  static String id = 'newUser';

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {

  LocationService locationService = new LocationService();

  void getLocationLatLong() async {
    await locationService.getLocation();
  }

  @override
  void initState() {
    super.initState();
    getLocationLatLong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We-Can'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              width: 160.0,
              height: 60.0,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.id);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 160.0,
              height: 60.0,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Register.id);
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'server',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String value) async {
                baseUrl = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
