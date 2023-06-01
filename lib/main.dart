import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          fontFamily: 'Montez',
          useMaterial3: true,
          splashColor: Colors.amber[800]!.withAlpha(50)),
      home: const PantryPage(titleTextValue: 'Edgar : Your Personal Chef'),
    );
  }
}

class PantryPage extends StatefulWidget {
  const PantryPage({super.key, required this.titleTextValue});

  final String titleTextValue;

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          color: Colors.grey[800],
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProductIconLabelButton(
                        productName: 'Potato',
                        productIcon: Icons.lunch_dining,
                        onPressed: _incrementCounter),
                    const ProductIconLabelButton(
                        productName: 'Tomato',
                        productIcon: Icons.dinner_dining),
                    const ProductIconLabelButton(
                        productName: 'Mango', productIcon: Icons.brunch_dining),
                  ],
                ),
              ),
              Container(
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
        ),
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
      this.onPressed});

  final String productName;
  final IconData productIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        productIcon,
      ),
      label: Text(
        productName,
        style: const TextStyle(
          fontSize: 25,
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
    );
  }
}
