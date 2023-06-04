import 'package:flutter/material.dart';

class FoodProduct {
  String name;
  Icon icon;
  bool isOnWatchList;
  bool isInShoppingList;
  bool isAllergen;
  List<String> diets;
  List<double> prices;
  double? lowestPrice;
  double? averagePrice;

  FoodProduct({
    required this.name,
    required this.icon,
    this.isOnWatchList = false,
    this.isInShoppingList = false,
    this.isAllergen = false,
    this.diets = const [],
    this.prices = const [],
  }) {
    if (prices.isNotEmpty) {
      lowestPrice = prices.reduce((a, b) => a < b ? a : b);
      averagePrice = prices.reduce((a, b) => a + b) / prices.length;
    }
  }
}
