import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/views/recipe_details.dart';
import 'package:flutter_meal/widget/common_widget.dart';
import 'package:flutter_meal/widget/recipe_button.dart';
import 'package:http/http.dart' as http;

class FilterCategory extends StatefulWidget {
  const FilterCategory({
    Key key,
    @required this.categoryTitle,
    @required this.categoryName,
    @required this.isRecipeDetails,
    @required this.isForSearch,
  }) : super(key: key);

  final String categoryTitle;
  final String categoryName;
  final bool isRecipeDetails;
  final bool isForSearch;

  @override
  _FilterCategoryState createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  Map filtercategorymap;
  List filtercategorydata;

  Future filtercategory() async {
    http.Response response;
    String url = ApiData.filtercategory + widget.categoryName;

    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        filtercategorymap = json.decode(response.body);
        filtercategorydata = filtercategorymap['meals'];
      });
    }
  }

  @override
  void initState() {
    filtercategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (filtercategorymap == null)
            ? Container()
            : (widget.isRecipeDetails)
                ? headerTitle(widget.categoryTitle, false)
                : headerTitle(widget.categoryTitle, true),
        (filtercategorymap == null)
            ? Container()
            : (widget.isForSearch)
                ? Container(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filtercategorydata.length,
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
                                    filtercategorydata[index]['strMealThumb'],
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
                                    filtercategorydata[index]['strMeal'],
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
                                    widget.categoryName,
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
                                            mealid: filtercategorydata[index]
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
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filtercategorydata.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                          child: (filtercategorydata[index]['strMealThumb'] ==
                                  "")
                              ? Container()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                filtercategorydata[index]
                                                    ['strMealThumb'],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              filtercategorydata[index]
                                                  ['strMeal'],
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 24,
                                                letterSpacing: 1,
                                                fontFamily: "ConcertOne",
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            RecipeButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        RecipeDetails(
                                                      mealid:
                                                          filtercategorydata[
                                                              index]['idMeal'],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
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
