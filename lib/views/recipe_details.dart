import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/widget/filter_category.dart';
import 'package:flutter_meal/widget/filter_country.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_meal/widget/show_alert_dialog.dart';

class RecipeDetails extends StatefulWidget {
  final String mealid;

  const RecipeDetails({Key key, this.mealid}) : super(key: key);
  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  Map mapresponse;
  List meals;
  YoutubePlayerController youtubePlayerController;
  String youtubeLink;

  Future fetchdata() async {
    http.Response response;

    String url = ApiData.filterMealId + widget.mealid;
    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        mapresponse = json.decode(response.body);
        meals = mapresponse["meals"];
      });
    } else {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later',
        defaultActionText: 'ok',
      );
    }
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (mapresponse == null)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return (meals.length == null)
                          ? Container()
                          : Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    meals[index]['strMealThumb'],
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                  Positioned(
                    top: 240,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              itemCount: meals.length,
                              itemBuilder: (context, index) {
                                return (meals.length == null)
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              meals[index]['strMeal'],
                                              style: TextStyle(
                                                fontSize: 35,
                                                letterSpacing: 1,
                                                fontFamily: "ConcertOne",
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  meals[index]['strCategory'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  height: 25,
                                                  width: 3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  meals[index]['strArea'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Ingredients :",
                                              style: TextStyle(
                                                fontSize: 24,
                                                letterSpacing: 1,
                                                fontFamily: "ConcertOne",
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            for (int i = 1; i <= 20; i++)
                                              (meals[index]['strIngredient' +
                                                          '$i'] ==
                                                      '')
                                                  ? Container()
                                                  : (meals[index][
                                                              'strIngredient' +
                                                                  '$i'] ==
                                                          null)
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 18,
                                                                    width: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    meals[index]
                                                                        [
                                                                        'strIngredient' +
                                                                            '$i'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  meals[index][
                                                                      'strMeasure' +
                                                                          '$i'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Directions :",
                                              style: TextStyle(
                                                fontSize: 24,
                                                letterSpacing: 1,
                                                fontFamily: "ConcertOne",
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              meals[index]['strInstructions'],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            (meals[index]['strYoutube'] == '')
                                                ? Container()
                                                : Container(
                                                    child: YoutubePlayer(
                                                      controller:
                                                          YoutubePlayerController(
                                                              initialVideoId:
                                                                  YoutubePlayer
                                                                      .convertUrlToId(
                                                                meals[index][
                                                                    'strYoutube'],
                                                              ),
                                                              flags:
                                                                  YoutubePlayerFlags(
                                                                      autoPlay:
                                                                          false)),
                                                      showVideoProgressIndicator:
                                                          true,
                                                      progressIndicatorColor:
                                                          Colors.blue,
                                                      progressColors:
                                                          ProgressBarColors(
                                                        playedColor:
                                                            Colors.blue,
                                                        handleColor:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(height: 15),
                                            FilterCountry(
                                              isRecipeDetails: true,
                                              isForSearch: false,
                                              countryTitle: "More " +
                                                  meals[index]['strArea'] +
                                                  " Recipes",
                                              countryName: meals[index]
                                                  ['strArea'],
                                            ),
                                            SizedBox(height: 10),
                                            FilterCategory(
                                              isRecipeDetails: true,
                                              isForSearch: false,
                                              categoryTitle: "See also",
                                              categoryName: meals[index]
                                                  ['strCategory'],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
