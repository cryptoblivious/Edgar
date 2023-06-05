import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_product.dart';
import 'stock_level.dart';

class PantryItem {
  FoodProduct foodProduct;
  bool isStaple; // Staple items are not removed from the pantry when they are used up
  StockLevel stockLevel;

  PantryItem({required this.foodProduct, required this.isStaple, this.stockLevel = StockLevel.inStock});

  factory PantryItem.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    PantryItem pantryItem = PantryItem(
      foodProduct: FoodProduct.fromFirestore(data?['foodProduct'] as DocumentSnapshot<Object?>),
      isStaple: data?['isStaple'] as bool? ?? false,
      stockLevel: StockLevel.values.firstWhere((element) => element.toString() == data?['stockLevel']),
    );
    return pantryItem;
  }

  Map<String, dynamic> vars() {
    Map<String, dynamic> variables = {
      'name': foodProduct.name,
      'isStaple': isStaple,
      'stockLevel': stockLevel,
    };
    return variables;
  }
}
