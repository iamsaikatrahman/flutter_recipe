import 'package:flutter/material.dart';
import 'package:flutter_meal/views/home.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFFEE8D0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Enjoy Cooking",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "ConcertOne",
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Delicious and detailed restaurant recipes on your phone.",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "ConcertOne",
                    letterSpacing: 1,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset("assets/on.png"),
              Center(
                child: Text(
                  "It\'s Cooking Time!",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "ConcertOne",
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 200,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xFFE8505F),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Home(),
                        ),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "ConcertOne",
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
