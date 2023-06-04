import 'package:flutter/material.dart';
import 'diet.dart';

class FoodProduct {
  String name;
  Icon icon;
  List<String> foodCategories;
  List<Diet> diets;
  late List<double> prices;
  double? lowestPrice;
  double? averagePrice;

  FoodProduct({
    required this.name,
    required this.icon,
    this.foodCategories = const [],
    this.diets = const [],
  }) {
    prices.isNotEmpty ? updatePrices(prices) : prices = const [];
  }

  void updatePrices(List<double> newPrices) {
    prices = newPrices;
    lowestPrice = prices.reduce((curr, next) => curr < next ? curr : next);
    averagePrice = prices.reduce((curr, next) => curr + next) / prices.length;
  }
}
