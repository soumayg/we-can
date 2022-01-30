import 'package:flutter/material.dart';
import 'screen/SplashScreen.dart';
import 'screen/LoginScreen.dart';
import 'screen/RegisterScreen.dart';
import 'screen/HomeScreen.dart';
import 'screen/LeadershipBoardScreen.dart';
import 'screen/QrScanResultScreen.dart';
import 'screen/NewUserScreen.dart';
import 'screen/RequestBinScreen.dart';
import 'screen/DepositBin.dart';
import 'screen/ReportBin.dart';

void main() {
  runApp(WeCan());
}

class WeCan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        Home.id: (context) => Home(),
        LeadershipBoard.id: (context) => LeadershipBoard(),
        LeadershipBoard.id: (context) => LeadershipBoard(),
        QrResult.id: (context) => QrResult(),
        NewUser.id: (context) => NewUser(),
        RequestBin.id: (context) => RequestBin(),
        Deposit.id: (context) => Deposit(),
        ReportBin.id: (context) => ReportBin(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
