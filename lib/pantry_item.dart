import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_product.dart';
import 'stock.dart';

class PantryItem {
  FoodProduct? foodProduct;
  bool? isStaple;
  Stock? stock;

  PantryItem({required this.foodProduct, required this.isStaple, this.stock = Stock.ok});

  PantryItem._create(dynamic item) {
    isStaple = (item['isStaple'] ?? false) as bool;
    stock = (Stock.values.firstWhere((category) => category.toString() == 'Stock.${item['stock']}') ?? Stock.ok);
  }

  static Future<PantryItem> createAsync(dynamic item) async {
    PantryItem pantryItem = PantryItem._create(item);
    await pantryItem._loadFromFirestore(item);
    return pantryItem;
  }

  Future<void> _loadFromFirestore(dynamic data) async {
    if (data['foodProduct'] is DocumentReference) {
      DocumentReference foodProductReference = data['foodProduct'] as DocumentReference;
      DocumentSnapshot foodProductSnapshot = await foodProductReference.get();
      foodProduct = FoodProduct.fromFirestore(foodProductSnapshot);
    }
    // factory PantryItem.fromFirestore(DocumentSnapshot snapshot) {
    //   Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    //   PantryItem pantryItem = PantryItem(
    //     foodProduct: FoodProduct.fromFirestore(data?['foodProduct'] as DocumentSnapshot<Object?>),
    //     isStaple: data?['isStaple'] as bool? ?? false,
    //     stockLevel: StockLevel.values.firstWhere((element) => element.toString() == data?['stockLevel']),
    //   );
    //   return pantryItem;
    // }
  }
}
