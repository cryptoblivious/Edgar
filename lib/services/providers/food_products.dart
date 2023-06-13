import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgar/models/food_product.dart';

// TODO : Check this works and implement the same logic for the user if so
final foodProductsProvider = StreamProvider.autoDispose<List<FoodProduct>>((ref) {
  final CollectionReference foodProductsCollectionRef = FirebaseFirestore.instance.collection('foodProducts');
  final Stream<QuerySnapshot> snapshots = foodProductsCollectionRef.snapshots();
  final Stream<List<FoodProduct>> foodProductsStream = snapshots.map((snapshot) => snapshot.docs.map((doc) => FoodProduct.fromFirestore(doc)).toList());
  return foodProductsStream;
});
