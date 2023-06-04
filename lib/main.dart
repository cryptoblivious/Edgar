import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pantry_page.dart';
import 'pantry_item_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Colors.deepPurple[900]!, // Set your desired status bar color here
    ));

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
