import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/views/recipe_details.dart';
import 'package:flutter_meal/widget/common_widget.dart';
import 'package:flutter_meal/widget/recipe_button.dart';
import 'package:http/http.dart' as http;

class FilterCountry extends StatefulWidget {
  final String countryTitle;
  final String countryName;
  final bool isRecipeDetails;
  final bool isForSearch;

  const FilterCountry({
    Key key,
    @required this.countryTitle,
    @required this.countryName,
    @required this.isRecipeDetails,
    @required this.isForSearch,
  }) : super(key: key);
  @override
  _FilterCountryState createState() => _FilterCountryState();
}

class _FilterCountryState extends State<FilterCountry> {
  Map filterCountrymap;
  List filterCountrydata;

  Future filterCountry() async {
    http.Response response;
    String url = ApiData.filterCountry + widget.countryName;
    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        filterCountrymap = json.decode(response.body);
        filterCountrydata = filterCountrymap['meals'];
      });
    }
  }

  @override
  void initState() {
    filterCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (filterCountrymap == null)
            ? Container()
            : (widget.isRecipeDetails)
                ? headerTitle(widget.countryTitle, false)
                : headerTitle(widget.countryTitle, true),
        (filterCountrymap == null)
            ? Container()
            : (widget.isForSearch)
                ? Container(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filterCountrydata.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    filterCountrydata[index]['strMealThumb'],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    filterCountrydata[index]['strMeal'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                      fontFamily: "ConcertOne",
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Text(
                                    widget.countryName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                      // fontFamily: "ConcertOne",
                                    ),
                                  ),
                                  RecipeButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RecipeDetails(
                                            mealid: filterCountrydata[index]
                                                ['idMeal'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filterCountrydata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(1, 3),
                                blurRadius: 3,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              (filterCountrydata[index]['strMealThumb'] == '')
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              filterCountrydata[index]
                                                  ['strMealThumb']),
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 120,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.65),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                        spreadRadius: -1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        filterCountrydata[index]['strMeal'],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          letterSpacing: 1,
                                          color: Colors.white,
                                          fontFamily: "ConcertOne",
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Text(
                                        widget.countryName + ' Food',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RecipeButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RecipeDetails(
                                          mealid: filterCountrydata[index]
                                              ['idMeal'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}
