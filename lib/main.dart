import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';

import 'package:edgar/services/routing/opening_page_commutator.dart';

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
    return MaterialApp(
      home: OpeningPageCommutator(appTitle: appTitle),
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple[900]!),
        fontFamily: 'Montez',
        useMaterial3: true,
        splashColor: Colors.deepPurple[200]!.withOpacity(0.1),
      ),
    );
  }
}
