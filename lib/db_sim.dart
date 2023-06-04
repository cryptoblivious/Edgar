import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'pantry_item.dart';
import 'food_product.dart';
import 'food_category.dart';
import 'diet.dart';

class DBSim {
  List<PantryItem> pantry;

  DBSim({this.pantry = const []}) {
    FoodProduct tomato = FoodProduct(
      name: 'Tomato',
      icon: const Icon(Icons.food_bank_outlined),
      foodCategories: [FoodCategory.fruitNvegetable],
      diets: [
        Diet.vegan,
        Diet.vegetarian,
        Diet.glutenFree,
        Diet.omnivore,
        Diet.lactoVegetarian
      ],
    );
    FoodProduct milk = FoodProduct(
      name: 'Milk',
      icon: const Icon(Icons.food_bank_outlined),
      foodCategories: [FoodCategory.dairy],
      diets: [
        Diet.vegan,
        Diet.vegetarian,
        Diet.glutenFree,
        Diet.omnivore,
        Diet.lactoVegetarian
      ],
    );
    FoodProduct bread = FoodProduct(
      name: 'Bread',
      icon: const Icon(Icons.food_bank_outlined),
      foodCategories: [FoodCategory.grain],
      diets: [
        Diet.vegan,
        Diet.vegetarian,
        Diet.glutenFree,
        Diet.omnivore,
        Diet.lactoVegetarian
      ],
    );
    FoodProduct egg = FoodProduct(
      name: 'Egg',
      icon: const Icon(Icons.food_bank_outlined),
      foodCategories: [FoodCategory.egg],
      diets: [
        Diet.vegetarian,
        Diet.glutenFree,
        Diet.omnivore,
        Diet.lactoVegetarian
      ],
    );
    FoodProduct cheese = FoodProduct(
      name: 'Cheese',
      icon: const Icon(Icons.food_bank_outlined),
      foodCategories: [FoodCategory.dairy],
      diets: [
        Diet.vegetarian,
        Diet.glutenFree,
        Diet.omnivore,
        Diet.lactoVegetarian
      ],
    );

    pantry.add(PantryItem(foodProduct: milk, isStaple: true));
    pantry.add(PantryItem(foodProduct: bread, isStaple: true));
    pantry.add(PantryItem(foodProduct: egg, isStaple: true));
    pantry.add(PantryItem(foodProduct: cheese, isStaple: true));
    pantry.add(PantryItem(foodProduct: tomato, isStaple: false));
  }
}
