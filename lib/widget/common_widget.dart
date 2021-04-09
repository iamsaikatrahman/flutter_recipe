import 'package:flutter/material.dart';

Padding headerTitle(String title, bool padding) {
  return Padding(
    padding: (padding)
        ? EdgeInsets.symmetric(horizontal: 14)
        : EdgeInsets.symmetric(horizontal: 0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontFamily: "ConcertOne",
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Card filterButton() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 3,
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.5,
          color: Colors.blueGrey,
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/filter.png"),
        ),
      ),
    ),
  );
}

Stack initialSearchScreen(BuildContext context) {
  return Stack(
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/search.png"),
          ),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.53,
        left: MediaQuery.of(context).size.width * 0.1,
        child: Text(
          "Search Your Favorite\nRecipes!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: "ConcertOne",
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
