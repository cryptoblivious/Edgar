import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/screens/loading_screen.dart';
import 'package:edgar/screens/sign_in_screen.dart';
import 'package:edgar/services/routing/router.dart' as edgar;

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
                return const edgar.Router();
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
      final newPantryDocRef = await FirebaseFirestore.instance.collection('pantries').add({'name': 'My Pantry', 'items': []});
      String uid = newPantryDocRef.id;
      await newPantryDocRef.update({'uid': uid});

      final newShoppingListDocRef = await FirebaseFirestore.instance.collection('shoppingLists').add({'name': 'My Shopping List', 'items': []});
      uid = newShoppingListDocRef.id;
      await newShoppingListDocRef.update({'uid': uid});

      final newWatchListDocRef = await FirebaseFirestore.instance.collection('watchLists').add({'name': 'My Watch List', 'items': []});
      uid = newWatchListDocRef.id;
      await newWatchListDocRef.update({'uid': uid});

      // Create the user document with the new pantry reference
      await userDocRef.set({
        'activePantry': 0,
        'friends': [],
        'pantries': [newPantryDocRef],
        'recipes': [],
        'shoppingList': [newShoppingListDocRef],
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
        'watchList': newWatchListDocRef,

        // Add more fields as needed for user profile
      });
    }
  }
}
