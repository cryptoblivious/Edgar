import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.fruitNvegetable],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct milk = FoodProduct(
      name: 'Milk',
      iconData: FontAwesomeIcons.cheese,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct bread = FoodProduct(
      name: 'Bread',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct egg = FoodProduct(
      name: 'Egg',
      iconData: FontAwesomeIcons.egg,
      foodCategories: [FoodCategory.egg],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct cheese = FoodProduct(
      name: 'Cheese',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct chicken = FoodProduct(
      name: 'Chicken',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct beef = FoodProduct(
      name: 'Beef',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct pork = FoodProduct(
      name: 'Pork',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct fish = FoodProduct(
      name: 'Fish',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct rice = FoodProduct(
      name: 'Rice',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct pasta = FoodProduct(
      name: 'Pasta',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct potato = FoodProduct(
      name: 'Potato',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct onion = FoodProduct(
      name: 'Onion',
      iconData: FontAwesomeIcons.breadSlice,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );

    user!.pantry.items.add(PantryItem(foodProduct: milk, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: bread, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: egg, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: cheese, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: tomato, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: chicken, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: beef, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: pork, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: fish, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: rice, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: pasta, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: potato, isStaple: true));
    user!.pantry.items.add(PantryItem(foodProduct: onion, isStaple: true));
  }
}
