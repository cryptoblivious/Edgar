import 'package:flutter/material.dart';
import 'pantry_item_card.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  int _selectedMenuIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey[700]!),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))))),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
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
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey[700]!),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))))),
                ],
              ),
              Expanded(
                child: ListView(
                  children: const [
                    PantryItemCard(
                      productName: 'Potato',
                      productType: Icons.lunch_dining,
                    ),
                    PantryItemCard(
                      productName: 'Tomato',
                      productType: Icons.dinner_dining,
                    ),
                    PantryItemCard(
                      productName: 'Mango',
                      productType: Icons.brunch_dining,
                    ),
                    PantryItemCard(
                      productName: 'Banana',
                      productType: Icons.breakfast_dining,
                    ),
                    PantryItemCard(
                      productName: 'Apple',
                      productType: Icons.food_bank,
                    ),
                    PantryItemCard(
                      productName: 'Orange',
                      productType: Icons.food_bank_outlined,
                    ),
                    PantryItemCard(
                      productName: 'Pineapple',
                      productType: Icons.food_bank_rounded,
                    ),
                    PantryItemCard(
                      productName: 'Grapes',
                      productType: Icons.food_bank_sharp,
                    ),
                    PantryItemCard(
                      productName: 'Potato',
                      productType: Icons.lunch_dining,
                    ),
                    PantryItemCard(
                      productName: 'Tomato',
                      productType: Icons.dinner_dining,
                    ),
                    PantryItemCard(
                      productName: 'Mango',
                      productType: Icons.brunch_dining,
                    ),
                    PantryItemCard(
                      productName: 'Banana',
                      productType: Icons.breakfast_dining,
                    ),
                    PantryItemCard(
                      productName: 'Apple',
                      productType: Icons.food_bank,
                    ),
                    PantryItemCard(
                      productName: 'Orange',
                      productType: Icons.food_bank_outlined,
                    ),
                    PantryItemCard(
                      productName: 'Pineapple',
                      productType: Icons.food_bank_rounded,
                    ),
                    PantryItemCard(
                      productName: 'Grapes',
                      productType: Icons.food_bank_sharp,
                    ),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: 'Pantry',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.dining_outlined),
                label: 'Recipes',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                label: 'Groceries',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
                backgroundColor: Colors.black),
          ],
        ));
  }
}
