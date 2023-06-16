import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/services/database/data_repository.dart';

import 'package:edgar/models/pantry.dart';
import 'package:edgar/models/pantry_item.dart';

class FirestoreRepository extends DataRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> getDataImpl() async {
    // Implementation specific to Firestore data retrieval
  }

  @override
  Future<void> updateDataImpl(Map<String, dynamic> data) async {
    if (data['object'] is Pantry) {
      updatePantry(data['object'] as Pantry);
    }
  }

  // Add other methods specific to Firestore

  Future<void> updatePantry(Pantry pantry) async {
    final pantryDocRef = _firestore.collection('pantries').doc(pantry.uid as String);
    final pantryDocSnapshot = await pantryDocRef.get();
    if (pantryDocSnapshot.exists) {
      await pantryDocRef.update(_pantryToMap(pantry));
    } else {
      throw Exception('Pantry does not exist');
    }
  }

  Map<String, dynamic> _pantryItemToMap(PantryItem pantryItem) {
    final foodProductDocRef = FirebaseFirestore.instance.collection('foodProducts').doc(pantryItem.foodProduct!.uid);
    Map<String, dynamic> map = {
      'foodProduct': foodProductDocRef,
      'isStaple': pantryItem.isStaple,
      'stock': pantryItem.stock.toString().split('.').last,
    };
    return map;
  }

  Map<String, dynamic> _pantryToMap(Pantry pantry) {
    Map<String, dynamic> map = {
      'name': pantry.name,
      'items': pantry.items.map((item) {
        return _pantryItemToMap(item);
      }).toList(),
    };
    return map;
  }
}
