import 'package:edgar/services/routing/subroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdgarBottomNavigationBar extends StatefulWidget {
  const EdgarBottomNavigationBar({super.key, required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  State<EdgarBottomNavigationBar> createState() => _EdgarBottomNavigationBarState();
}

class _EdgarBottomNavigationBarState extends State<EdgarBottomNavigationBar> {
  int _selectedMenuIndex = 0;

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    if (index != _selectedMenuIndex) {
      setState(() {
        _selectedMenuIndex = index;
      });
      widget.onItemTapped(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedMenuIndex,
      onTap: _onItemTapped,
      iconSize: 24,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      unselectedFontSize: 18,
      selectedFontSize: 24,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: const Icon(Icons.inventory_2_outlined), label: 'Pantry', backgroundColor: Theme.of(context).colorScheme.inverseSurface),
        BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_basket_outlined), label: 'Groceries', backgroundColor: Theme.of(context).colorScheme.inverseSurface),
        BottomNavigationBarItem(icon: const Icon(Icons.dining_outlined), label: 'Recipes', backgroundColor: Theme.of(context).colorScheme.inverseSurface),
        BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: 'Profile', backgroundColor: Theme.of(context).colorScheme.inverseSurface),
        BottomNavigationBarItem(icon: const Icon(Icons.settings_outlined), label: 'Settings', backgroundColor: Theme.of(context).colorScheme.inverseSurface),
      ],
    );
  }
}
