import 'package:edgar/services/routing/opening_page_commutator.dart';
import 'package:flutter/material.dart';

import 'package:edgar/screens/pantry_screen.dart';
import 'package:edgar/screens/groceries_screen.dart';
import 'package:edgar/screens/recipes_screen.dart';
import 'package:edgar/screens/profile_screen.dart';
import 'package:edgar/screens/settings_screen.dart';
import 'package:edgar/models/user.dart';

import 'package:edgar/widgets/placeholders/screen_ph.dart';

Map<String, Widget Function(User)> subroutes = {
  '/pantry': (user) => PantryScreen(user: user),
  '/groceries': (user) => const ScreenPlaceholder(name: 'Groceries Screen'),
  '/recipes': (user) => const ScreenPlaceholder(name: 'Recipes Screen'),
  '/profile': (user) => const ScreenPlaceholder(name: 'Profile Screen'),
  '/settings': (user) => const ScreenPlaceholder(name: 'Settings Screen'),
  '/': (user) => const OpeningPageCommutator(),
};
