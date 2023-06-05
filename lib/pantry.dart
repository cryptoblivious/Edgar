import 'package:cloud_firestore/cloud_firestore.dart';

import 'pantry_item.dart';
import 'stock_level.dart';

class Pantry {
  List<PantryItem> items = [];

  Pantry();

  void handleItemChanged(PantryItem item) {
    int index = items.indexOf(item);
    if (index != -1) {
      if (!item.isStaple && item.stockLevel == StockLevel.outOfStock) {
        print('Removing item from pantry');
        items.remove(item);
      }
    }
  }

  factory Pantry.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    Pantry pantry = Pantry();
    print('Pantry items: ${data?['items']}');
    // print each field in each item
    data?['items'].forEach((itemData) {
      itemData?.forEach((key, value) {
        print('$key: $value');
      });
    });

    //pantry.items = data?['items']?.map((itemData) => PantryItem.fromFirestore(itemData as DocumentSnapshot<Object?>)) as List<PantryItem>? ?? [];
    return pantry;
  }
}
