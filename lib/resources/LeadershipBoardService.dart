import 'package:flutter/material.dart';
import 'package:wecann/resources/constants.dart';
import 'LineResponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Results.dart';

const String rank = 'Rank';
const String username = 'Username';
const String pointS = 'Points';

TextStyle kTableTextStyle(FontWeight fontWeight) {
  return TextStyle(
    fontWeight: fontWeight,
    letterSpacing: 1.5,
    fontSize: 18.0,
  );
}

Container xContainer(String textContainer, FontWeight fontWeight) {
  return Container(
    child: Text(
      textContainer,
      style: kTableTextStyle(fontWeight),
      textAlign: TextAlign.center,
    ),
    width: 69,
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
  );
}

Text drawTableBorder(){
  return Text(
    '|',
    style: kTableTextStyle(FontWeight.bold),
  );
}

Expanded userName(String username, FontWeight fontWeight) {
  return Expanded(
    child: Container(
      child: Text(
        username,
        style: kTableTextStyle(fontWeight),
        textAlign: TextAlign.center,
      ),
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    ),
  );
}

Container getRow(@required String rank, @required String username, @required String points, FontWeight fontWeight) {
  return Container(
    child: Row(
      children: [
        xContainer(rank, fontWeight),
        drawTableBorder(),
        userName(username, fontWeight),
        drawTableBorder(),
        xContainer(points, fontWeight),
      ],
    ),
  );
}

Future<List<Result>> getData() async {
  List<Result> list = [];
  var res = await http.get(Uri.parse('${baseUrl}/karmaboard'));
  if (res.statusCode == 200) {
    var data = json.decode(res.body);
    print(data);
    var rest = data["data"] as List;
    list = rest.map<Result>((json) => Result.fromJson(json)).toList();
    print(list);
  }
  return list;
}
