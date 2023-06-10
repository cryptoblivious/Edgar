import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/providers/user.dart';

import '../models/pantry_item.dart';
import '../models/user.dart';

import '../screens/loading_screen.dart';

import '../widgets/edgar_bottom_navigation_bar.dart';
import '../widgets/pantry_item_card.dart';
import '../widgets/add_items_to_pantry_card.dart';
import '../widgets/filter_button.dart';
import '../widgets/view_options_button.dart';

class PantryScreen extends ConsumerWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, child) {
        final asyncUserDocumentSnapshot = ref.watch(userProvider);

        if (asyncUserDocumentSnapshot.isLoading) {
          // User document is not available yet
          return const LoadingScreen(message: 'Bringing out the cookbooks...');
        } else if (asyncUserDocumentSnapshot.error != null) {
          // Error occurred while fetching the user document
          return Scaffold(
            body: Center(
              child: Text('Error occurred: ${asyncUserDocumentSnapshot.error}'),
            ),
          );
        } else {
          // User document is available
          final userSnapshot = asyncUserDocumentSnapshot.value;

          return FutureBuilder<User>(
            future: User.createAsync(userSnapshot!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // User is still being created
                return const LoadingScreen(message: 'Cleaning the pots and pans...');
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

  void _toggleAddingItemsMenu() {
    if (_isAddItemsMenuOpen) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        width: 200,
        content: Text(
          'Menu already open',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          width: 200,
          content: Text(
            'Menu opening',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.none,
        ),
      );
    }

    setState(() {
      _isAddItemsMenuOpen = !_isAddItemsMenuOpen;
    });
  }

  void handleItemChanged(PantryItem pantryItem, String variable) {
    setState(() {
      widget.user.pantries![widget.user.activePantry].handleItemChanged(pantryItem, variable);
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
            children: <Widget>[
              Row(
                children: [
                  const ViewOptionsButton(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          Text(
                            'Search',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSecondaryContainer),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const FilterButton(),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...user.pantries![user.activePantry].items
                        .map((pantryItem) => PantryItemCard(
                              pantryItem: pantryItem,
                              onItemChanged: handleItemChanged,
                            ))
                        .toList(),
                    AddItemsToPantryCard(onPressed: _toggleAddingItemsMenu),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO : Add view component for adding items
          // Probably the best way will be to turn the current content widget into a content switcher and add a new content widget for adding items
          HapticFeedback.selectionClick();
          _toggleAddingItemsMenu();
        },
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Icon(_isAddItemsMenuOpen ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.plus,
            color: Theme.of(context).colorScheme.onSecondaryContainer), // TODO : Change icon based on menu state
      ),
      bottomNavigationBar: const EdgarBottomNavigationBar(),
    );
  }
}
