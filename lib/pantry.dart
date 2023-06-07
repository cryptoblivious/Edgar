import 'package:cloud_firestore/cloud_firestore.dart';

import 'pantry_item.dart';
import 'stock.dart';

class Pantry {
  String? name;
  List<PantryItem> items = [];

  Pantry({this.name = 'Home'});

  void handleItemChanged(PantryItem item, String variable) {
    item.handleItemChanged(variable);
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
        items.add(pantryItem);
      }
    }
  }
}
