import 'package:edgar/services/routing/opening_page_commutator.dart';
import 'package:flutter/material.dart';

import 'package:edgar/screens/pantry_screen.dart';
import 'package:edgar/screens/groceries_screen.dart';
import 'package:edgar/screens/recipes_screen.dart';
import 'package:edgar/screens/profile_screen.dart';
import 'package:edgar/screens/settings_screen.dart';

import 'package:edgar/widgets/placeholders/screen_ph.dart';

Map<String, Widget> subroutes = {
  '/pantry': const PantryScreen(),
  '/groceries': const ScreenPlaceholder(name: 'Potatoes Screen'),
  '/recipes': const ScreenPlaceholder(name: 'Recipes Screen'),
  '/profile': const ScreenPlaceholder(name: 'Profile Screen'),
  '/settings': const ScreenPlaceholder(name: 'Settings Screen'),
  '/': const OpeningPageCommutator(),
};
