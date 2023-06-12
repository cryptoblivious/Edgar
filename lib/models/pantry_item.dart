import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edgar/models/food_product.dart';
import 'package:edgar/models/stock.dart';

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
  }

  void change(String variable) {
    if (variable == 'isStaple') {
      isStaple = !isStaple!;
    } else if (variable == 'stock') {
      if (stock == Stock.ok) {
        stock = Stock.low;
      } else if (stock == Stock.low) {
        stock = Stock.out;
      } else if (stock == Stock.out) {
        stock = Stock.ok;
      }
    }
    if (isStaple! && (stock == Stock.low || stock == Stock.out)) {
      // TODO : Add logic to add to shopping list
      print('Sending ${foodProduct?.name} to shopping list');
    } else if (stock == Stock.ok) {
      // TODO : Add logic to remove from shopping list
      print('Removing ${foodProduct?.name} from shopping list');
    }
  }
}
