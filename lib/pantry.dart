import 'package:cloud_firestore/cloud_firestore.dart';

import 'pantry_item.dart';
import 'stock.dart';

class Pantry {
  String? name;
  List<PantryItem> items = [];

  Pantry({this.name = 'Home'});

  void handleItemChanged(PantryItem item) {
    int index = items.indexOf(item);
    if (index != -1) {
      if (!item.isStaple! && item.stock == Stock.out) {
        print('Removing item from pantry');
        items.remove(item);
      }
    }
  }

  Pantry._create(dynamic item) {
    name = (item['name'] ?? 'Home') as String;
    items = [];
  }

  static Future<Pantry> createAsync(DocumentSnapshot snapshot) async {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    Pantry pantry = Pantry._create(data);
    await pantry._loadFromFirestore(data);
    return pantry;
  }

  Future<void> _loadFromFirestore(Map<String, dynamic>? data) async {
    if (data?.containsKey('items') == true && data?['items'] is List) {
      print(data?['items']);
      List<dynamic> itemsData = (data?['items'] ?? []) as List<dynamic>;
      for (dynamic itemData in itemsData) {
        PantryItem pantryItem = await PantryItem.createAsync(itemData);
        print('Item data: $itemData');
        print('Item data type: ${itemData['foodProducts']}');
        //PantryItem item = PantryItem.fromFirestore(itemData);
        //items.add(item);
      }
      // List<Map<String, dynamic>> itemsData = (data?['items'] ?? []) as List<Map<String, dynamic>>;
      // for (Map<String, dynamic> itemData in itemsData) {
      //   List<dynamic> foodProductsData = (itemData['foodProducts'] ?? []) as List<dynamic>;
      //   print('Food products data: $foodProductsData');
      //PantryItem item = PantryItem.fromFirestore(food);
      //items.add(item);
    }
    // List<DocumentReference> foodProductReferences = List<DocumentReference>.from(foodProductsData);

    // await Future.wait(
    //   foodProductReferences.map((itemRef) async {
    //     DocumentSnapshot itemSnapshot = await itemRef.get();
    //     print('Pantry item document data: ${itemSnapshot.data()}');
    //     PantryItem item = PantryItem.fromFirestore(itemSnapshot);
    //     items.add(item);
    //   }),
    // );
  }
}
