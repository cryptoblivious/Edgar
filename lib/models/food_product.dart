import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:edgar/models/diet.dart';
import 'package:edgar/models/food_category.dart';
import 'package:edgar/services/database/icon_strings_to_icons.dart';
import 'package:edgar/models/pricing.dart';

class FoodProduct {
  String name;
  String description;
  String mainCategory;
  IconData iconData;
  List<FoodCategory> categories;
  List<Diet> diets;
  Pricing? pricing;

  FoodProduct({
    required this.name,
    required this.description,
    required this.mainCategory,
    required this.iconData,
    required this.categories,
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
      description: data?['description'] as String? ?? '',
      mainCategory: data?['mainCategory'] as String? ?? '',
      iconData: iconStringsToIcons[data?['mainCategory']] ?? FontAwesomeIcons.x,
      categories: foodCategories,
      diets: diets,
      //pricing: Pricing.fromFirestore(data?['pricing']),
    );

    return foodProduct;
  }
}
