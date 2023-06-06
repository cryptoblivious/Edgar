import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_in_page.dart';
import 'pantry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple[900]!, // Set your desired status bar color here
    ));

    return MaterialApp(
      title: 'Edgar : Your Personal Chef',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: 'Montez',
        useMaterial3: true,
        splashColor: Colors.amber[800]!.withAlpha(50),
      ),
      home: FutureBuilder(
        // Check if the user is already signed in
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // User is signed in, proceed to the authenticated page
            return const PantryPage();
          } else {
            // User is not signed in, show the FirebaseUI authentication page
            // TODO : Build a custom authentication page
            //return const Placeholder();
            return const SignInPage();
          }
        },
      ),
    );
  }
}
