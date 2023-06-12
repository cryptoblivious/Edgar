import 'package:flutter/material.dart';
import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';
import 'package:edgar/services/mappers/subroutes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String currentScreen = '/pantry';

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      currentScreen = subroutes.keys.toList()[index].toString();
      print(currentScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: subroutes[currentScreen],
      bottomNavigationBar: EdgarBottomNavigationBar(onItemTapped: _onBottomNavigationItemTapped),
    );
  }
}
