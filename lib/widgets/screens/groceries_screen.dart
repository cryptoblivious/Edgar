import 'package:edgar/models/food_product.dart';
import 'package:edgar/widgets/bars/pantry_screen_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:edgar/models/user.dart';

import 'package:edgar/widgets/subscreens/grocery_cards_subscreen.dart';
import 'package:edgar/widgets/subscreens/add_items_to_groceries_subscreen.dart';

class GroceryScreen extends StatefulWidget {
  final User user;
  final List<FoodProduct> foodProducts;

  const GroceryScreen({Key? key, required this.user, required this.foodProducts}) : super(key: key);

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  bool _isAddItemsMenuOpen = false;

  void _toggleAddingItems() {
    setState(() {
      _isAddItemsMenuOpen = !_isAddItemsMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Access the user object from the widget
    const searchBar = EdgarTopSearchBar();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            children: [
              searchBar,
              _isAddItemsMenuOpen
                  ? AddItemsToGroceriesSubscreen(user: user, foodProducts: widget.foodProducts)
                  : GroceryCardsSubscreen(user: user, onPressed: _toggleAddingItems, sortSetting: 'name'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.selectionClick();
          _toggleAddingItems();
        },
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Icon(_isAddItemsMenuOpen ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.plus,
            color: Theme.of(context).colorScheme.onSecondaryContainer), // TODO : Change icon based on menu state
      ),
    );
  }
}
