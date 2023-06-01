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
      home: const Home(titleTextValue: 'Edgar : Your Personal Chef'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.titleTextValue});

  final String titleTextValue;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = const PantryBody();
        break;
      case 1:
        body = const Text('Recipes');
        break;
      case 2:
        body = const Text('Groceries');
        break;
      default:
        body = const Text('Pantry');
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Image.asset('assets/icons/edgar.png'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.titleTextValue,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 2.0,
                  )),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 22,
                  child: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.onPrimary, size: 35),
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: body,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .background, // Set the desired background color for the ledge
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 36,
            unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
            selectedItemColor: Colors.amber[800],
            unselectedFontSize: 18,
            selectedFontSize: 24,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            backgroundColor: Theme.of(context).colorScheme.primary,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.view_in_ar_sharp),
                label: 'Pantry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dining_outlined),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                label: 'Groceries',
              ),
            ],
          ),
        ));
  }
}

class ProductIconLabelButton extends StatelessWidget {
  const ProductIconLabelButton(
      {super.key,
      required this.productName,
      required this.productIcon,
      required this.onPressed});

  final String productName;
  final IconData productIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          productIcon,
        ),
        label: Text(
          productName,
          style: const TextStyle(
            fontSize: 20,
          ),
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

class PantryBody extends StatefulWidget {
  const PantryBody({super.key});

  @override
  State<PantryBody> createState() => _PantryBodyState();
}

class _PantryBodyState extends State<PantryBody> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[800],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: constraints.maxWidth * 0.5,
                  child: const Text(
                    'Search bar goes here',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                ProductIconLabelButton(
                    productName: 'Potato',
                    productIcon: Icons.lunch_dining,
                    onPressed: _incrementCounter),
                ProductIconLabelButton(
                    productName: 'Tomato',
                    productIcon: Icons.dinner_dining,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Mango',
                    productIcon: Icons.brunch_dining,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Banana',
                    productIcon: Icons.breakfast_dining,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Apple',
                    productIcon: Icons.food_bank,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Orange',
                    productIcon: Icons.food_bank_outlined,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Pineapple',
                    productIcon: Icons.food_bank_rounded,
                    onPressed: () {}),
                ProductIconLabelButton(
                    productName: 'Grapes',
                    productIcon: Icons.food_bank_sharp,
                    onPressed: () {}),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'You have pushed the potato button this many times : $_counter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
