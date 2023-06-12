import 'package:edgar/services/commutators/opening_page_commutator.dart';
import 'package:flutter/material.dart';

import 'package:edgar/screens/pantry_screen.dart';
import 'package:edgar/screens/groceries_screen.dart';
import 'package:edgar/screens/recipes_screen.dart';
import 'package:edgar/screens/profile_screen.dart';
import 'package:edgar/screens/settings_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const OpeningPageCommutator(),
  '/pantry': (context) => const PantryScreen(),
  '/groceries': (context) => const GroceriesScreen(),
  '/recipes': (context) => const RecipesScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/settings': (context) => const SettingsScreen(),
};
