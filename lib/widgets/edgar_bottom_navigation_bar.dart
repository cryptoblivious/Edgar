import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdgarBottomNavigationBar extends StatefulWidget {
  const EdgarBottomNavigationBar({super.key});

  @override
  State<EdgarBottomNavigationBar> createState() => _EdgarBottomNavigationBarState();
}

class _EdgarBottomNavigationBarState extends State<EdgarBottomNavigationBar> {
  int _selectedMenuIndex = 0;

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedMenuIndex,
      onTap: _onItemTapped,
      iconSize: 24,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
      selectedItemColor: Colors.deepPurple[300],
      unselectedFontSize: 18,
      selectedFontSize: 24,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Pantry', backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.dining_outlined), label: 'Recipes', backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: 'Groceries', backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile', backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings', backgroundColor: Colors.black),
      ],
    );
  }
}
