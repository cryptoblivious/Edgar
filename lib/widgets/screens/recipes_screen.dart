import 'package:edgar/widgets/subscreens/recipe_wizard_subscreen.dart';
import 'package:flutter/material.dart';
import 'package:edgar/models/user.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key, required this.user});

  final User user;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return const RecipeWizardSubscreen();
  }
}
