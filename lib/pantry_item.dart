import 'food_product.dart';

enum StockLevel { inStock, runningLow, outOfStock }

class PantryItem {
  FoodProduct foodProduct;
  bool isStaple;
  StockLevel stockLevel = StockLevel.inStock;

  PantryItem({required this.foodProduct, required this.isStaple, stockLevel});
}
