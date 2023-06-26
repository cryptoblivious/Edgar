import 'package:flutter/material.dart';
import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text('Recipes Screen'));
  }
}
