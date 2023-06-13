import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edgar/services/providers/user.dart';
import 'package:edgar/services/providers/food_products.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/food_product.dart';

import 'package:edgar/screens/loading_screen.dart';

import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';
import 'package:edgar/services/routing/subroutes.dart';

class RoutingScreen extends ConsumerStatefulWidget {
  const RoutingScreen({super.key});

  @override
  RoutingScreenState createState() => RoutingScreenState();
}

class RoutingScreenState extends ConsumerState<RoutingScreen> {
  String currentScreen = '/pantry';
  User? initialUser;
  List<FoodProduct>? initialFoodProducts;

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
        final asyncFoodProductsSnapshot = ref.watch(foodProductsProvider);

        if (asyncUserDocumentSnapshot.isLoading || asyncFoodProductsSnapshot.isLoading) {
          // Snapshot is not available yet
          return LoadingScreen();
        } else if (asyncUserDocumentSnapshot.error != null || asyncFoodProductsSnapshot.error != null) {
          // Error occurred while fetching a snapshot
          return Scaffold(
            body: Center(
              child: Text('Error occurred: ${asyncUserDocumentSnapshot.error}'),
            ),
          );
        } else {
          // Snapshots are available
          final user = asyncUserDocumentSnapshot.value;
          final foodProducts = asyncFoodProductsSnapshot.value;

          if (initialFoodProducts == null || initialFoodProducts != foodProducts) {
            initialFoodProducts = foodProducts;
          }

          if (initialUser == null || initialUser != user) {
            initialUser = user;
          }
          return Scaffold(
            body: (subroutes[currentScreen] as Widget Function(User, List<FoodProduct>)).call(initialUser!, initialFoodProducts!),
            bottomNavigationBar: EdgarBottomNavigationBar(onItemTapped: _onBottomNavigationItemTapped),
          );
        }
      },
    );
  }
}
