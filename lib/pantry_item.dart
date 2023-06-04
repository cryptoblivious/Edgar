import 'food_product.dart';
import 'stock_level.dart';

class PantryItem {
  FoodProduct foodProduct;
  bool isStaple; // Staple items are not removed from the pantry when they are used up
  StockLevel stockLevel;

  PantryItem({required this.foodProduct, required this.isStaple, this.stockLevel = StockLevel.inStock});

  Map<String, dynamic> vars() {
    Map<String, dynamic> variables = {
      'name': foodProduct.name,
      'isStaple': isStaple,
      'stockLevel': stockLevel,
    };
    return variables;
  }
}
