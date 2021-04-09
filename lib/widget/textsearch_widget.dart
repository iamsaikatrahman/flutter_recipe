import 'package:flutter/material.dart';
import 'package:flutter_meal/views/recipe_details.dart';
import 'package:flutter_meal/widget/recipe_button.dart';

class TextSearchWidget extends StatelessWidget {
  const TextSearchWidget({
    Key key,
    @required this.productResultList,
  }) : super(key: key);

  final List productResultList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: productResultList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return (productResultList[index]['strMealThumb'] == '')
              ? Container()
              : Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            productResultList[index]['strMealThumb'],
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            productResultList[index]['strMeal'],
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
                            productResultList[index]['strCategory'],
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                          RecipeButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RecipeDetails(
                                    mealid: productResultList[index]['idMeal'],
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
    );
  }
}
