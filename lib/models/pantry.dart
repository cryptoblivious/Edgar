import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/models/pantry_item.dart';

class Pantry {
  String? name;
  List<PantryItem> items = [];

  Pantry({this.name = 'Home'});

  void changeItem(PantryItem item, String variable) {
    item.change(variable);
  }

  void addItem(PantryItem item) {
    items.add(item);
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
      List<dynamic> itemsData = (data?['items'] ?? []) as List<dynamic>;
      for (final dynamic itemData in itemsData) {
        PantryItem pantryItem = await PantryItem.createAsync(itemData);
        items.add(pantryItem);
      }
    }
  }
}
