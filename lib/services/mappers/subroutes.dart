import 'package:edgar/services/commutators/opening_page_commutator.dart';
import 'package:flutter/material.dart';

import 'package:edgar/screens/pantry_screen.dart';
import 'package:edgar/screens/groceries_screen.dart';
import 'package:edgar/screens/recipes_screen.dart';
import 'package:edgar/screens/profile_screen.dart';
import 'package:edgar/screens/settings_screen.dart';

Map<String, Widget> subroutes = {
  '/pantry': const PantryScreen(),
  '/groceries': const GroceriesScreen(),
  '/recipes': const RecipesScreen(),
  '/profile': const ProfileScreen(),
  '/settings': const SettingsScreen(),
  '/': const OpeningPageCommutator(),
};
