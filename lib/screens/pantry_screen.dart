import 'package:edgar/models/food_product.dart';
import 'package:edgar/widgets/bars/pantry_screen_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/user.dart';

import 'package:edgar/screens/subscreens/owned_item_cards_subscreen.dart';
import 'package:edgar/screens/subscreens/add_items_to_pantry_subscreen.dart';

class PantryScreen extends StatefulWidget {
  final User user;
  final List<FoodProduct> foodProducts;

  const PantryScreen({Key? key, required this.user, required this.foodProducts}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  bool _isAddItemsMenuOpen = false;

  void _toggleAddingItems() {
    setState(() {
      _isAddItemsMenuOpen = !_isAddItemsMenuOpen;
    });
  }

  void handleItemUpdated(PantryItem pantryItem, String variable) {
    setState(() {
      widget.user.pantries![widget.user.activePantry].changeItem(pantryItem, variable);
    });
  }

  void handleItemAdded(PantryItem pantryItem) {
    setState(() {
      widget.user.pantries![widget.user.activePantry].addItem(pantryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Access the user object from the widget

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            children: [
              const PantryScreenSearchBar(),
              _isAddItemsMenuOpen
                  ? AddItemsToPantrySubscreen(user: user, foodProducts: widget.foodProducts, onItemAdded: handleItemAdded)
                  : OwnedItemCardsSubscreen(user: user, onItemUpdated: handleItemUpdated, onPressed: _toggleAddingItems),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO : Add view component for adding items
          // Probably the best way will be to turn the current content widget into a content switcher and add a new content widget for adding items
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
