import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'diet.dart';
import 'food_category.dart';
import '../services/icon_mapping.dart';
import 'pricing.dart';

class FoodProduct {
  String name;
  IconData iconData;
  List<FoodCategory> foodCategories;
  List<Diet> diets;
  Pricing? pricing;

  FoodProduct({
    required this.name,
    required this.iconData,
    required this.foodCategories,
    required this.diets,
    this.pricing,
  });

  factory FoodProduct.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    // Convert the list of food categories from Firestore data to FoodCategory enum values
    List<dynamic> foodCategoryData = (data?['categories'] ?? []) as List<dynamic>;
    List<String> foodCategoryStrings = List<String>.from(foodCategoryData);
    List<FoodCategory> foodCategories = foodCategoryStrings
        .map((categoryString) => FoodCategory.values.firstWhere((category) => category.toString() == 'FoodCategory.$categoryString'))
        .toList();

    // Convert the list of diets from Firestore data to Diet enum values
    List<dynamic> dietsData = (data?['diets'] ?? []) as List<dynamic>;
    List<String> dietStrings = List<String>.from(dietsData);
    List<Diet> diets = dietStrings.map((dietString) => Diet.values.firstWhere((diet) => diet.toString() == 'Diet.$dietString')).toList();

    FoodProduct foodProduct = FoodProduct(
      name: data?['name'] as String? ?? '',
      iconData: iconMap[data?['icon']] ?? FontAwesomeIcons.egg,
      foodCategories: foodCategories,
      diets: diets,
      //pricing: Pricing.fromFirestore(data?['pricing']),
    );

    return foodProduct;
  }
}