import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/views/recipe_details.dart';
import 'package:flutter_meal/views/search.dart';
import 'package:flutter_meal/widget/filter_category.dart';
import 'package:flutter_meal/widget/filter_country.dart';
import 'package:flutter_meal/widget/recipe_button.dart';
import 'package:flutter_meal/widget/show_alert_dialog.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = new ScrollController();

  Map mapresponse, filtercategorymap, randomPhotoMap;
  List meals, filtercategorydata;
  String randomPhotoUrl;
  var isVisible = false;

  Future fetchRandomPhoto() async {
    http.Response response;
    String url = ApiData.randomFoodPicture;
    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        randomPhotoMap = json.decode(response.body);
        randomPhotoUrl = randomPhotoMap['image'];
      });
    }
  }

  Future fetchdata() async {
    http.Response response;
    String url = ApiData.randomMeal;
    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        mapresponse = json.decode(response.body);
        meals = mapresponse["meals"];
      });
    }
  }

  @override
  void initState() {
    _getRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) if (isVisible)
          setState(() {
            isVisible = false;
          });
      } else {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
    });
    super.initState();
  }

  Future<void> _getRefresh() async {
    try {
      await fetchdata();
      await fetchRandomPhoto();
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later',
        defaultActionText: 'ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Visibility(
          visible: isVisible,
          child: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.blueGrey[50],
            ),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _getRefresh,
          child: Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What would you\nlike to cook?",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "ConcertOne",
                            letterSpacing: 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Search(),
                              ),
                            );
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.1 - 18,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1.5, color: Colors.blueGrey),
                            ),
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  (randomPhotoMap == null)
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(randomPhotoUrl),
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "300+\nCooking Tips and Tricks.",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: "ConcertOne",
                                          letterSpacing: 1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Now you stay home and cook what you want!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "ConcertOne",
                                          letterSpacing: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "Today Special",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "ConcertOne",
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  (mapresponse == null)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            return (meals[index]['strMealThumb'] == '')
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                meals[index]['strMealThumb'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Container(
                                            height: 170,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.65),
                                                  offset: Offset(1, 1),
                                                  blurRadius: 2,
                                                  spreadRadius: -1,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    meals[index]['strMeal'],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      letterSpacing: 1,
                                                      color: Colors.white,
                                                      fontFamily: "ConcertOne",
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          meals[index]
                                                              ['strCategory'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Container(
                                                        height: 25,
                                                        width: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Flexible(
                                                        child: Text(
                                                          meals[index]
                                                              ['strArea'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  RecipeButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              RecipeDetails(
                                                            mealid: meals[index]
                                                                ['idMeal'],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                  SizedBox(height: 10),
                  FilterCategory(
                    isRecipeDetails: false,
                    isForSearch: false,
                    categoryTitle: "Desserts",
                    categoryName: "Dessert",
                  ),
                  SizedBox(height: 10),
                  FilterCountry(
                    isRecipeDetails: false,
                    isForSearch: false,
                    countryTitle: "Italian Recipe",
                    countryName: "Italian",
                  ),
                  SizedBox(height: 10),
                  FilterCategory(
                    isRecipeDetails: false,
                    isForSearch: false,
                    categoryTitle: "Breakfast",
                    categoryName: "Breakfast",
                  ),
                  SizedBox(height: 10),
                  FilterCountry(
                    isRecipeDetails: false,
                    isForSearch: false,
                    countryTitle: "American Recipe",
                    countryName: "American",
                  ),
                  SizedBox(height: 10),
                  FilterCategory(
                    isRecipeDetails: false,
                    isForSearch: false,
                    categoryTitle: "Seafood",
                    categoryName: "Seafood",
                  ),
                   SizedBox(height: 10),
                  FilterCountry(
                    isRecipeDetails: false,
                    isForSearch: false,
                    countryTitle: "Indian Recipe",
                    countryName: "Indian",
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
