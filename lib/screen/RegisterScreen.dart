import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:wecann/resources/constants.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We-Can Register User'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7.0,),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (String value) async {
                  kUsername = value;
                },
              ),
            ),
            TextButton(
              onPressed: () async{
                try {
                  final userRegister = await http.post(Uri.parse(
                      '${baseUrl}/register/${kUsername}'));
                  if (userRegister.statusCode == 201) {
                    Navigator.pushReplacementNamed(context, Home.id);
                  }
                }
                catch (e){}
              },
              child: Text('Register',style: TextStyle(color: Colors.black),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
