import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/providers/providers.dart';
import '../widgets/pantry_item_card.dart';
import '../models/pantry_item.dart';
import '../models/user.dart';

void showAddingItemsSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      width: 250,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Text(
        'Opening adding items menu...',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.none,
    ),
  );
}

class PantryPage extends ConsumerWidget {
  const PantryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, child) {
        final asyncUserDocumentSnapshot = ref.watch(userSnapshotProvider);

        if (asyncUserDocumentSnapshot.isLoading) {
          // User document is not available yet
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
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

          return FutureBuilder<User>(
            future: User.createAsync(userSnapshot!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // User is still being created
                return Scaffold(
                  body: SafeArea(
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Exploring new ingredients...', style: TextStyle(color: Colors.white, fontSize: 32)),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: 250,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.deepPurple[100]!,
                              color: Colors.deepPurple[800]!,
                            ),
                          ),
                        ],
                      ),
                    ),
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
          color: Colors.grey[800],
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: IconButton(
                      icon: const Icon(Icons.view_list_outlined),
                      onPressed: () {
                        // TODO : Implement view options
                        null;
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
                        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[800]!),
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
                      onPressed: () {
                        // TODO : Implement filter options
                        null;
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[300]!),
                        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[800]!),
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
                        onItemChanged: handleItemChanged,
                      );
                    }).toList(),
                    TextButton(
                      onPressed: () {
                        // TODO : Add view component for adding items
                        HapticFeedback.selectionClick();
                        showAddingItemsSnackbar(context);
                      },
                      child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.deepPurple[900]!,
                              )),
                          child: Center(
                            child: Text(
                              'Add more items to your pantry!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, color: Colors.deepPurple[900]),
                            ),
                          )),
                    ),
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
          HapticFeedback.selectionClick();
          showAddingItemsSnackbar(context);
        },
        backgroundColor: Colors.deepPurple[400]!,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
