import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc('pzUf9DQQhSCcUxzpHhAd').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
              elevation: 0,
              leading: Image.asset('assets/icons/edgar_gp_noborder.png'),
              title: Text(appTitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 2.0,
                  )),
              centerTitle: true,
            ),
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Theme.of(context).colorScheme.onSecondary.withOpacity(0.04);
                            }
                            if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                              return Theme.of(context).colorScheme.onSecondary.withOpacity(0.12);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      icon: const Icon(FontAwesomeIcons.google, size: 36),
                      label: const Text('Sign in with Google', style: TextStyle(fontSize: 36)),
                      onPressed: () async {
                        await signInWithGoogle(context);
                      }),
                ],
              ),
            )),
          );
        });
  }
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e, stackTrace) {
    // Handle the error and report to Crashlytics
    FirebaseCrashlytics.instance.recordError(e, stackTrace);

    // Handle the error within the app's UI
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(fontSize: 20),
          title: const Text('Sign-In Error'),
          content: const Text('Failed to sign in with Google. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // Rethrow the error to propagate it further if needed
    rethrow;
  }
}
