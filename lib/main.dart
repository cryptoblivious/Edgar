import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';

import 'screens/sign_in_page.dart';
import 'screens/pantry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  const settings = Settings(persistenceEnabled: true);
  firestore.settings = settings;

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();

  // Set the status bar and bottom navigation bar color to black
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple[800],
      systemNavigationBarColor: Colors.deepPurple[800],
    ),
  );

  runZonedGuarded(() {
    runApp(const ProviderScope(child: App()));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  final String appTitle = 'Edgar: Your Culinary Assistant';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: 'Montez',
        useMaterial3: true,
        splashColor: Colors.deepPurple[300]!.withAlpha(50),
      ),
      home: StreamBuilder<User?>(
        // Listen to the user authentication state changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            print('User is signed in! Data : ${snapshot.data}');
            // User is signed in, navigate to the authenticated page
            return FutureBuilder<void>(
              future: linkUserWithDocument(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: SafeArea(
                      child: Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Cleaning the pots and pans...', style: TextStyle(color: Colors.white, fontSize: 32)),
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
                  // Handle error scenario if necessary
                  return Text('Error: ${snapshot.error}');
                } else {
                  // User document is created or updated, navigate to PantryPage
                  return const PantryPage();
                }
              },
            );
          } else {
            // User is not signed in, show the FirebaseUI authentication page
            return SignInPage(appTitle: appTitle);
          }
        },
      ),
    );
  }
}

// Function to create or update the user document in Firestore

Future<void> linkUserWithDocument() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userDocSnapshot = await userDocRef.get();
    if (!userDocSnapshot.exists) {
      // Generate a new pantry document
      final newPantryDocRef = await FirebaseFirestore.instance.collection('pantries').add({
        // Add pantry data here
        'name': 'My Pantry',
        'items': [
          {'foodProduct': FirebaseFirestore.instance.collection('foodProducts').doc('hf58XDYIy4zU6Wjn34Jj'), 'isStaple': true, 'stock': 'ok'},
          {'foodProduct': FirebaseFirestore.instance.collection('foodProducts').doc('l5A6RZppRSSqxBYxLqfd'), 'isStaple': true, 'stock': 'ok'},
        ]
      });

      // Create the user document with the new pantry reference
      await userDocRef.set({
        'activePantry': 0,
        'friends': [],
        'pantries': [newPantryDocRef],
        'recipes': [],
        'shoppingList': [],
        'settings': {
          'darkMode': true,
          'language': 'en',
          'notifications': false,
        },
        'profile': {
          'broadAllergens': [],
          'diets': [],
          'email': user.email,
          'favouriteCuisines': [],
          'name': user.displayName,
          'photoURL': user.photoURL,
          'specificAllergens': [],
        },
        'uid': user.uid,
        'watchList': [],

        // Add more fields as needed for user profile
      });
    }
  }
}
