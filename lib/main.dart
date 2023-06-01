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
      home: const HomePage(titleTextValue: 'Edgar : Your Personal Chef'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.titleTextValue});

  final String titleTextValue;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(
                      Icons.lunch_dining,
                    ),
                    label: const Text(
                      'Potato',
                      style: TextStyle(
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
                  ),
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(
                      Icons.lunch_dining,
                    ),
                    label: const Text(
                      'Tomato',
                      style: TextStyle(
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
                  ),
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(
                      Icons.lunch_dining,
                    ),
                    label: const Text(
                      'Mango',
                      style: TextStyle(
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
                  ),
                ],
              ),
              const Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: NetworkImage(
                            'https://images.pexels.com/photos/16998585/pexels-photo-16998585/free-photo-of-food-apple-agriculture-fall.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                        semanticLabel: 'Fruits on display',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 80,
                      child: Center(
                        child: Text(
                          '(You have pushed the potato button this many times) :',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Text(
                        '$_counter',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
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
