import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text('Grocery Screen'));
  }
}
