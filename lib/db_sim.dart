import 'package:flutter/material.dart';

import 'user.dart';
import 'pantry_item.dart';
import 'food_product.dart';
import 'food_category.dart';
import 'diet.dart';

class DBSim {
  User? user;

  DBSim({this.user}) {
    user ??= User();

    FoodProduct tomato = FoodProduct(
      name: 'Tomato',
      iconData: Icons.food_bank_outlined,
      foodCategories: [FoodCategory.fruitNvegetable],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct milk = FoodProduct(
      name: 'Milk',
      iconData: Icons.food_bank_outlined,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct bread = FoodProduct(
      name: 'Bread',
      iconData: Icons.food_bank_outlined,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct egg = FoodProduct(
      name: 'Egg',
      iconData: Icons.food_bank_outlined,
      foodCategories: [FoodCategory.egg],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct cheese = FoodProduct(
      name: 'Cheese',
      iconData: Icons.food_bank_outlined,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );

    user!.pantry.add(PantryItem(foodProduct: milk, isStaple: true));
    user!.pantry.add(PantryItem(foodProduct: bread, isStaple: true));
    user!.pantry.add(PantryItem(foodProduct: egg, isStaple: true));
    user!.pantry.add(PantryItem(foodProduct: cheese, isStaple: true));
    user!.pantry.add(PantryItem(foodProduct: tomato, isStaple: false));
  }
}
