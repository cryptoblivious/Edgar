import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'providers.dart';
import 'pantry_item_card.dart';
import 'pantry_item.dart';
import 'db_sim.dart';
import 'user.dart';

class PantryPage extends ConsumerWidget {
  const PantryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, child) {
        final asyncUserDocumentSnapshot = ref.watch(userSnapshotProvider);

        if (asyncUserDocumentSnapshot.isLoading) {
          // User document is not available yet
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
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
          print('User snapshot: $userSnapshot');

          return FutureBuilder<User>(
            future: User.createAsync(userSnapshot!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // User is still being created
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
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
                return PantryPageContent(user: user);
              } else {
                // Future has completed, but no data was returned
                // You can handle this case accordingly
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

class PantryPageContent extends StatefulWidget {
  final User user;

  const PantryPageContent({Key? key, required this.user}) : super(key: key);

  @override
  State<PantryPageContent> createState() => _PantryPageContentState();
}

class _PantryPageContentState extends State<PantryPageContent> {
  int _selectedMenuIndex = 0;

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  void _handlePantryItemChanged(PantryItem pantryItem) {
    setState(() {
      int activePantry = widget.user.activePantry;
      widget.user.pantries![activePantry].handleItemChanged(pantryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Access the user object from the widget

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[800],
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: IconButton(
                      icon: const Icon(Icons.view_list_outlined),
                      color: Colors.white,
                      onPressed: () {
                        HapticFeedback.selectionClick();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[700]!),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          Text(
                            'Search',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      color: Colors.white,
                      onPressed: () {
                        HapticFeedback.selectionClick();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[700]!),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...user.pantries![user.activePantry].items.map((pantryItem) {
                      return PantryItemCard(
                        pantryItem: pantryItem,
                        onItemChanged: _handlePantryItemChanged,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.selectionClick();
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedMenuIndex,
        onTap: _onItemTapped,
        iconSize: 24,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedItemColor: Colors.amber[800],
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
      ),
    );
  }
}
