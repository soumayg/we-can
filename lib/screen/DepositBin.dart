import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecann/resources/constants.dart';
import 'package:http/http.dart' as http;

class Deposit extends StatelessWidget {
  static String id = deposit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We-Can Clean'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Thanks for being kind to the society',style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: double.infinity,),
          ],
        ),
      ),
    );
  }
}

Future<void> postDeposit() async {
  final userRegister = await http.post(Uri.parse('${baseUrl}/user/${kUsername}/can/${kQrResult}'));
  print(userRegister.body);
  await getUserPoints();
}

Future<void> getUserPoints() async {
  final user = await http.get(Uri.parse('${baseUrl}/user/${kUsername}'));
  if (user.statusCode == 200) {
    var data = json.decode(user.body);
    var rest = data["score"] as int;
    points = rest;
  }
}