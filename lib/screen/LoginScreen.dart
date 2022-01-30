import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:wecann/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We-Can'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 7.0,
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (String value) async {
                  kUsername = value;
                },
              ),
            ),
            Text(text, style: TextStyle(color: Colors.red),),
            TextButton(
              onPressed: () async {
                try {
                  final user = await http.get(Uri.parse('${baseUrl}/user/${kUsername}'));
                  if (user.statusCode == 200) {
                    var data = json.decode(user.body);
                    points = data["score"] as int;
                    Navigator.pushReplacementNamed(context, Home.id);
                  } else {
                    text = 'No user exists. Please register!';
                    setState(() {});
                  }
                } catch (e) {}
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
          ],
        ),
      ),
    );
  }
}
