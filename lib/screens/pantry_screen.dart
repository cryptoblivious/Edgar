import 'package:edgar/widgets/bars/pantry_screen_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:edgar/services/providers/user.dart';

import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/user.dart';

import 'package:edgar/screens/loading_screen.dart';
import 'package:edgar/screens/subscreens/owned_item_cards_subscreen.dart';
import 'package:edgar/screens/subscreens/add_items_to_pantry_subscreen.dart';

class PantryScreen extends ConsumerWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, child) {
        final asyncUserDocumentSnapshot = ref.watch(userProvider);
        final asyncFoodProductsCollectionSnapshot = ref.watch(foodProductsCollectionProvider);

        if (asyncUserDocumentSnapshot.isLoading || asyncFoodProductsCollectionSnapshot.isLoading) {
          // Snapshot is not available yet
          return LoadingScreen();
        } else if (asyncUserDocumentSnapshot.error != null || asyncFoodProductsCollectionSnapshot.error != null) {
          // Error occurred while fetching a snapshot
          return Scaffold(
            body: Center(
              child: Text('Error occurred: ${asyncUserDocumentSnapshot.error}'),
            ),
          );
        } else {
          // Snaphots are available
          final userSnapshot = asyncUserDocumentSnapshot.value;
          final foodProductsCollectionSnapshot = asyncFoodProductsCollectionSnapshot.value;

          return FutureBuilder<User>(
            future: User.createAsync(userSnapshot!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // User is still being created
                return LoadingScreen();
              } else if (snapshot.hasError) {
                // Error occurred while creating the user
                return Scaffold(
                  body: Center(
                    child: Text('Error occurred: ${snapshot.error}'),
                  ),
                );
              } else if (snapshot.hasData) {
                // User is created successfully
                final user = snapshot.data!;
                return PantryScreenContent(user: user);
              } else {
                // Future has completed, but no data was returned
                return const Scaffold(
                  body: Center(
                    child: Text('No user data available'),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

class PantryScreenContent extends StatefulWidget {
  final User user;

  const PantryScreenContent({Key? key, required this.user}) : super(key: key);

  @override
  State<PantryScreenContent> createState() => _PantryScreenContentState();
}

class _PantryScreenContentState extends State<PantryScreenContent> {
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
                  ? AddItemsToPantrySubscreen(user: user, onItemAdded: handleItemAdded)
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
