import 'package:edgar/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';

import 'screens/sign_in_screen.dart';
import 'screens/pantry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  const settings = Settings(persistenceEnabled: true);
  firestore.settings = settings;

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();

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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.deepPurple[900]!,
        systemNavigationBarColor: Colors.deepPurple[900]!,
      ),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple[900]!),
          fontFamily: 'Montez',
          useMaterial3: true,
          splashColor: Colors.deepPurple[200]!.withOpacity(0.1),
        ),
        home: StreamBuilder<User?>(
          // Listen to the user authentication state changes
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Show loading screen while the user authentication state is loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen(message: 'Warming up the oven...');
            } else if (snapshot.hasData) {
              print('User is signed in! Data : ${snapshot.data}');
              // User is signed in, navigate to the authenticated page
              return FutureBuilder<void>(
                future: linkUserWithDocument(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  // Show loading screen while the user document is created or updated
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen(message: 'Cleaning the pots and pans...');
                  } else if (snapshot.hasError) {
                    // Handle error scenario if necessary
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // User document is created or updated, navigate to PantryPage
                    return const PantryScreen();
                  }
                },
              );
            } else {
              // User is not signed in, show the FirebaseUI authentication page
              return SignInScreen(appTitle: appTitle);
            }
          },
        ),
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
