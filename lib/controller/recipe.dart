import 'package:flutter/material.dart';

class Recipe {
  final String idMeal;
  final String title;
  final String strCategory;
  final String strArea;
  final String strMealThumb;

  const Recipe({
    @required this.idMeal,
    @required this.title,
    @required this.strCategory,
    @required this.strArea,
    @required this.strMealThumb,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        idMeal: json['idMeal'],
        strCategory: json['strCategory'],
        title: json['strMeal'],
        strArea: json['strArea'],
        strMealThumb: json['strMealThumb'],
      );

     

  Map<String, dynamic> toJson() => {
        'idMeal': idMeal,
        'strMeal': title,
        'strCategory': strCategory,
        'strArea': strArea,
        'strMealThumb': strMealThumb,
      };
      
}
