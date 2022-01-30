import 'dart:io';
import 'package:flutter/material.dart';
import 'NewUserScreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1,), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      if (animation.isCompleted){
        sleep(const Duration(seconds: 1));
        Navigator.pushReplacementNamed(context, NewUser.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/appDescriptionBackgroundImage.png'),
            fit: BoxFit.cover,
            opacity: controller.value,
          ),
        ),
        child: Center(
          child: Image.asset(
            'images/icon.png',
            height: 90,
          ),
        ),
      ),
    );
  }
}
