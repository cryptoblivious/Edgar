import 'package:flutter/material.dart';

class FoodProduct {
  String name;
  Icon icon;
  List<String> foodCategories;
  List<String> diets;
  List<double> prices;
  double? lowestPrice;
  double? averagePrice;

  FoodProduct({
    required this.name,
    required this.icon,
    this.foodCategories = const [],
    this.diets = const [],
    this.prices = const [],
  }) {
    if (prices.isNotEmpty) {
      lowestPrice = prices.reduce((a, b) => a < b ? a : b);
      averagePrice = prices.reduce((a, b) => a + b) / prices.length;
    }
  }
}
