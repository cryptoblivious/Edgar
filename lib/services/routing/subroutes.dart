import 'package:edgar/services/routing/opening_page_commutator.dart';
import 'package:flutter/material.dart';

import 'package:edgar/screens/pantry_screen.dart';
import 'package:edgar/screens/groceries_screen.dart';
import 'package:edgar/screens/recipes_screen.dart';
import 'package:edgar/screens/profile_screen.dart';
import 'package:edgar/screens/settings_screen.dart';
import 'package:edgar/models/user.dart';
import 'package:edgar/models/food_product.dart';

import 'package:edgar/widgets/placeholders/screen_ph.dart';

// TODO : Find a way to pass user and foodProducts to required screens without passing them to all screens or prop drilling
Map<String, Widget Function(User, List<FoodProduct>)> subroutes = {
  '/pantry': (user, foodProducts) => PantryScreen(user: user, foodProducts: foodProducts),
  '/groceries': (user, foodProducts) => GroceryScreen(user: user, foodProducts: foodProducts),
  '/recipes': (user, foodProducts) => const ScreenPlaceholder(name: 'Recipes Screen'),
  '/profile': (user, foodProducts) => const ScreenPlaceholder(name: 'Profile Screen'),
  '/settings': (user, foodProducts) => const ScreenPlaceholder(name: 'Settings Screen'),
  '/': (user, foodProducts) => const OpeningPageCommutator(),
};
