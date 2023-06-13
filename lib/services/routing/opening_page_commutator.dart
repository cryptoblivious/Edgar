import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/screens/loading_screen.dart';
import 'package:edgar/screens/sign_in_screen.dart';
import 'package:edgar/screens/routing_screen.dart';

class OpeningPageCommutator extends StatelessWidget {
  const OpeningPageCommutator({super.key, this.appTitle = 'Edgar: Your Culinary Assistant'});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen to the user authentication state changes
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading screen while the user authentication state is loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else if (snapshot.hasData) {
          // User is signed in, navigate to the authenticated page
          return FutureBuilder<void>(
            future: linkUserWithDocument(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              // Show loading screen while the user document is created or updated
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              } else if (snapshot.hasError) {
                // Handle error scenario if necessary
                return Text('Error: ${snapshot.error}');
              } else {
                // User document is created or updated, navigate to PantryPage
                return const RoutingScreen();
              }
            },
          );
        } else {
          // User is not signed in, show the FirebaseUI authentication page
          return SignInScreen(appTitle: appTitle);
        }
      },
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
