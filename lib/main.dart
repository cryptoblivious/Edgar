import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edgar : Your Personal Chef',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          fontFamily: 'Montez',
          useMaterial3: true,
          splashColor: Colors.amber[800]!.withAlpha(50)),
      home: const PantryPage(),
    );
  }
}

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
    Widget body;
    switch (_selectedMenuIndex) {
      case 0:
        body = const PantryBody();
        break;
      case 1:
        body = Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Center(
                child: Text('Recipes', style: TextStyle(fontSize: 64))));
        break;
      case 2:
        body = Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Center(
                child: Text('Groceries', style: TextStyle(fontSize: 64))));
        break;
      case 3:
        body = Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Center(
                child: Text('Profile', style: TextStyle(fontSize: 64))));
        break;
      case 4:
        body = Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Center(
                child: Text('Settings', style: TextStyle(fontSize: 64))));
        break;
      default:
        throw UnimplementedError('No widget for index $_selectedMenuIndex');
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Center(
            child: Row(
              children: [
                const Icon(Icons.search, size: 35, color: Colors.white),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Search bar goes here',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: body,
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

class ProductIconLabelButton extends StatefulWidget {
  const ProductIconLabelButton(
      {super.key, required this.productName, required this.productIcon});

  final String productName;
  final IconData productIcon;

  @override
  State<ProductIconLabelButton> createState() => _ProductIconLabelButtonState();
}

class _ProductIconLabelButtonState extends State<ProductIconLabelButton> {
  List<IconData> icons = [
    Icons.add,
    Icons.cached,
    Icons.one_x_mobiledata,
  ];

  void _rotateIcon() {
    setState(() {
      //make it so the second icon is the first icon, and the first icon is the last icon
      icons.add(icons.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextButton.icon(
        onPressed: _rotateIcon,
        icon: Icon(
          widget.productIcon,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icons[0]),
          ],
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.amber[800]!.withAlpha(50);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
      ),
    );
  }
}

class PantrySearchContent extends StatefulWidget {
  const PantrySearchContent({super.key});

  @override
  State<PantrySearchContent> createState() => _PantrySearchContentState();
}

class _PantrySearchContentState extends State<PantrySearchContent> {
  String? selectedItem;

  void _setSelectedItem(String e) {
    setState(() {
      selectedItem = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey[800],
        child: Column(
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: constraints.maxWidth,
                  child: const Text(
                    'Search bar goes here',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                );
              },
            ),
            const Expanded(
              child: Wrap(
                children: [
                  ProductIconLabelButton(
                    productName: 'Potato',
                    productIcon: Icons.lunch_dining,
                  ),
                  ProductIconLabelButton(
                    productName: 'Tomato',
                    productIcon: Icons.dinner_dining,
                  ),
                  ProductIconLabelButton(
                    productName: 'Mango',
                    productIcon: Icons.brunch_dining,
                  ),
                  ProductIconLabelButton(
                    productName: 'Banana',
                    productIcon: Icons.breakfast_dining,
                  ),
                  ProductIconLabelButton(
                    productName: 'Apple',
                    productIcon: Icons.food_bank,
                  ),
                  ProductIconLabelButton(
                    productName: 'Orange',
                    productIcon: Icons.food_bank_outlined,
                  ),
                  ProductIconLabelButton(
                    productName: 'Pineapple',
                    productIcon: Icons.food_bank_rounded,
                  ),
                  ProductIconLabelButton(
                    productName: 'Grapes',
                    productIcon: Icons.food_bank_sharp,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: const Text('No of search results goes here',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}

class PantryBody extends StatefulWidget {
  const PantryBody({super.key});

  @override
  State<PantryBody> createState() => _PantryBodyState();
}

class _PantryBodyState extends State<PantryBody> {
  int _selectedSubmenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_selectedSubmenuIndex) {
      case 0:
        body = const PantrySearchContent();
        break;
      case 1:
        body = Expanded(
          child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Center(
                  child: Text('Inventory', style: TextStyle(fontSize: 64)))),
        );
        break;
      case 2:
        body = Expanded(
          child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Center(
                  child: Text('Staples', style: TextStyle(fontSize: 64)))),
        );
        break;
      case 3:
        body = Expanded(
          child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Center(
                  child: Text('One timers', style: TextStyle(fontSize: 64)))),
        );
      default:
        throw UnimplementedError('No widget for index $_selectedSubmenuIndex');
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        width: double.infinity,
        color: Colors.grey[800],
        child: Row(
          children: [
            SafeArea(
                child: NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              selectedIndex: _selectedSubmenuIndex,
              unselectedIconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onSecondary),
              unselectedLabelTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              selectedLabelTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold),
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedSubmenuIndex = index;
                });
              },
              extended: constraints.maxWidth >= 600,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  selectedIcon: Icon(Icons.search),
                  label: Text('Search'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.view_in_ar_sharp),
                  selectedIcon: Icon(Icons.view_in_ar_sharp),
                  label: Text('Inventory'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.cached_outlined),
                  selectedIcon: Icon(Icons.cached_outlined),
                  label: Text('Staples'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.one_x_mobiledata_outlined),
                  selectedIcon: Icon(Icons.one_x_mobiledata_outlined),
                  label: Text('One timers'),
                ),
              ],
            )),
            body,
          ],
        ),
      ),
    );
  }
}
