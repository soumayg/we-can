import 'package:flutter/material.dart';
import 'package:wecann/resources/LeadershipBoardService.dart';
import 'package:wecann/resources/Results.dart';
import 'package:wecann/resources/constants.dart';


class LeadershipBoard extends StatefulWidget {
  static String id = 'leadershipBoard';
  @override
  _LeadershipBoardState createState() => _LeadershipBoardState();
}

class _LeadershipBoardState extends State<LeadershipBoard>{
  List<Result> leadershipBoard = [];
  List<Container> leadershipBoardItems = [];

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    getLeadershipBoard();
  }

  void getLeadershipBoard() async {
    leadershipBoard = await getData();
    await getLeadershipBoardItems();
    setState(() {});
  }

  Future<void> getLeadershipBoardItems() async {
    for (Result lineResponse in leadershipBoard) {
      leadershipBoardItems.add(getRow(
          lineResponse.rank.toString(),
          lineResponse.name,
          lineResponse.score.toString(),
          FontWeight.normal));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karma Board'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        margin: EdgeInsets.all(6.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
                width: double.infinity,
              ),
              getRow(rank, username, pointS, FontWeight.bold),
              Container(
                child: Column(
                  children: leadershipBoardItems,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
