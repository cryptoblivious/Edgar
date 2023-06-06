import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'sign_in_page.dart';
import 'pantry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
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
      home: StreamBuilder<User?>(
        // Listen to the user authentication state changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // User is signed in, navigate to the authenticated page
            linkUserWithDocument(); // Call the function to link the user with the document

            return const PantryPage();
          } else {
            // User is not signed in, show the FirebaseUI authentication page
            return const SignInPage();
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
      // Create the user document if it doesn't exist
      await userDocRef.set({
        'uid': user.uid,
        // Add more fields as needed for user profile
      });
    }
  }
}
