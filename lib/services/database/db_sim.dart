import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../models/pantry.dart';
import '../../models/pantry_item.dart';
import '../../models/food_product.dart';
import '../../models/food_category.dart';
import '../../models/diet.dart';

class DBSim {
  User? user;

  DBSim({this.user}) {
    user ??= User();

    FoodProduct tomato = FoodProduct(
      name: 'Tomato',
      icon: 'tomato',
      description:
          'A tomato is a nutrient-dense superfood that offers benefit to a range of bodily systems. Its nutritional content supports healthful skin, weight loss, and heart health.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.fruitNVegetable],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct milk = FoodProduct(
      name: 'Milk',
      icon: 'milk',
      description:
          'Milk is a nutrient-rich liquid food produced by the mammary glands of mammals. It is the primary source of nutrition for young mammals, including breastfed human infants before they are able to digest solid food.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct bread = FoodProduct(
      name: 'Bread',
      icon: 'bread',
      description:
          'Bread is a staple food prepared from a dough of flour and water, usually by baking. Throughout recorded history, it has been a prominent food in large parts of the world.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct egg = FoodProduct(
      name: 'Egg',
      icon: 'egg',
      description: 'Eggs are eggs.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.egg],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct cheese = FoodProduct(
      name: 'Cheese',
      icon: 'cheese',
      description: 'Cheese is cheese.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.dairy],
      diets: [Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct chicken = FoodProduct(
      name: 'Chicken',
      icon: 'chicken',
      description: 'Chicken is chicken.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct beef = FoodProduct(
      name: 'Beef',
      icon: 'beef',
      description: 'Beef is beef.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct pork = FoodProduct(
      name: 'Pork',
      icon: 'pork',
      description: 'Pork is pork.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct fish = FoodProduct(
      name: 'Fish',
      icon: 'fish',
      description: 'Fish is fish.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.meatNPoultry],
      diets: [Diet.omnivore, Diet.carnivore],
    );
    FoodProduct rice = FoodProduct(
      name: 'Rice',
      icon: 'rice',
      description: 'Rice is rice.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct pasta = FoodProduct(
      name: 'Pasta',
      icon: 'pasta',
      description: 'Pasta is pasta.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct potato = FoodProduct(
      name: 'Potato',
      icon: 'potato',
      description: 'Potato is potato.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );
    FoodProduct onion = FoodProduct(
      name: 'Onion',
      icon: 'onion',
      description: 'Onion is onion.',
      iconData: Icons.egg,
      foodCategories: [FoodCategory.grain],
      diets: [Diet.vegan, Diet.vegetarian, Diet.glutenFree, Diet.omnivore, Diet.lactoVegetarian],
    );

    user!.pantries?.add(Pantry());
    user!.pantries?[0].items.add(PantryItem(foodProduct: milk, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: bread, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: egg, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: cheese, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: tomato, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: chicken, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: beef, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: pork, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: fish, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: rice, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: pasta, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: potato, isStaple: true));
    user!.pantries?[0].items.add(PantryItem(foodProduct: onion, isStaple: true));
  }

  User getUser() {
    return user!;
  }
}
