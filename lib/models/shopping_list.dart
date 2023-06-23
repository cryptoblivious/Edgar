import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/models/food_product.dart';

class ShoppingList {
  String? name;
  String? uid;
  List<FoodProduct> items = [];
  // TODO : Add a field to link a shopping list to a pantry
  String? relatedPantryUid;

  void addItem(FoodProduct product) {
    items.add(product);
  }

  void removeItem(FoodProduct product) {
    String uid = product.uid;
    items.removeWhere((item) => item.uid == uid);
  }

  bool containsItem(FoodProduct product) {
    String uid = product.uid;
    return items.any((item) => item.uid == uid);
  }

  ShoppingList._create(dynamic data) {
    name = (data['name'] ?? 'My Shopping List') as String;
    uid = (data['uid'] ?? '') as String;
    items = [];
  }

  static Future<ShoppingList> createAsync(DocumentSnapshot snapshot) async {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    ShoppingList shoppingList = ShoppingList._create(data);
    await shoppingList._loadFromFirestore(data);
    return shoppingList;
  }

  Future<void> _loadFromFirestore(Map<String, dynamic>? data) async {
    if (data?.containsKey('items') == true && data?['items'] is List) {
      List<dynamic> itemsData = (data?['items'] ?? []) as List<dynamic>;
      for (final dynamic itemData in itemsData) {
        DocumentSnapshot foodProductSnapshot = await itemData.get() as DocumentSnapshot;
        FoodProduct foodProduct = FoodProduct.fromFirestore(foodProductSnapshot);
        items.add(foodProduct);
      }
    }
  }
}
