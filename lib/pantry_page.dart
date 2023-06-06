import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pantry_item_card.dart';
import 'pantry_item.dart';
import 'db_sim.dart';
import 'user.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  int _selectedMenuIndex = 0;
  //User user = User(); // Initialize with an empty user or default value
  User user = DBSim().user!;
  void _onItemTapped(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  void _handlePantryItemChanged(PantryItem pantryItem) {
    setState(() {
      int activePantry = user.activePantry; // Assuming activePantry is guaranteed to have a value
      user.pantries?[activePantry].handleItemChanged(pantryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc('pzUf9DQQhSCcUxzpHhAd').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const CircularProgressIndicator();
          // }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('User data not found');
          }

          // Parse the data from the snapshot and update the user variable
          //user = User.fromFirestore(snapshot.data!);

          // make the app wait for the user data to be fetched before building the UI
          if (user.pantries == null) {
            return const CircularProgressIndicator();
          }

          // Continue building your UI using the updated user data
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
                                onPressed: () {},
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[700]!),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))))),
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
                                onPressed: () {},
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[700]!),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ))))),
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
              )),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
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
              ));
        });
  }
}
