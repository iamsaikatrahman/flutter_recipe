import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meal/views/onboarding.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Onboarding()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE7DDD4),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/logo.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            Center(
              child: Text(
                "FlutterRecipe",
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "ConcertOne",
                  color: Color(0xFFA23522),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SpinKitSquareCircle(
              color: Color(0xFFA23522),
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
