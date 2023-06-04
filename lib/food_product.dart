import 'package:flutter/material.dart';
import 'diet.dart';
import 'food_category.dart';

class FoodProduct {
  String name;
  IconData iconData;
  List<FoodCategory> foodCategories;
  List<Diet> diets;
  List<double> prices = [];
  double? lowestPrice;
  double? averagePrice;

  FoodProduct({
    required this.name,
    required this.iconData,
    required this.foodCategories,
    required this.diets,
  });
}
