import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edgar/services/providers/user.dart';

import 'package:edgar/models/user.dart';

import 'package:edgar/screens/loading_screen.dart';

import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';
import 'package:edgar/services/routing/subroutes.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  String currentScreen = '/pantry';
  DocumentSnapshot? initialUserSnapshot;
  User? user;

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      currentScreen = subroutes.keys.toList()[index].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final asyncUserDocumentSnapshot = ref.watch(userProvider);

        if (asyncUserDocumentSnapshot.isLoading) {
          // Snapshot is not available yet
          return LoadingScreen();
        } else if (asyncUserDocumentSnapshot.error != null) {
          // Error occurred while fetching a snapshot
          return Scaffold(
            body: Center(
              child: Text('Error occurred: ${asyncUserDocumentSnapshot.error}'),
            ),
          );
        } else {
          // Snapshots are available
          final userSnapshot = asyncUserDocumentSnapshot.value;

          if (user == null || initialUserSnapshot != userSnapshot) {
            initialUserSnapshot = userSnapshot;
            return FutureBuilder<User>(
              future: User.createAsync(userSnapshot!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // User is still being created
                  return LoadingScreen();
                } else if (snapshot.hasError) {
                  // Error occurred while creating the user
                  return Scaffold(
                    body: Center(
                      child: Text('Error occurred: ${snapshot.error}'),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  // Future has completed, but no data was returned
                  return const Scaffold(
                    body: Center(
                      child: Text('No user data available'),
                    ),
                  );
                } else {
                  // User is created successfully
                  user = snapshot.data!;
                  return Scaffold(
                    body: (subroutes[currentScreen] as Widget Function(User)).call(user!),
                    bottomNavigationBar: EdgarBottomNavigationBar(onItemTapped: _onBottomNavigationItemTapped),
                  );
                }
              },
            );
          } else {
            return Scaffold(
              body: (subroutes[currentScreen] as Widget Function(User)).call(user!),
              bottomNavigationBar: EdgarBottomNavigationBar(onItemTapped: _onBottomNavigationItemTapped),
            );
          }
        }
      },
    );
  }
}
