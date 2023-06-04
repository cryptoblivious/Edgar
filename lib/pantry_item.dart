import 'food_product.dart';

enum StockLevel { inStock, runningLow, outOfStock }

class PantryItem {
  FoodProduct foodProduct;
  bool
      isStaple; // Staple items are not removed from the pantry when they are used up
  StockLevel stockLevel;

  PantryItem(
      {required this.foodProduct,
      required this.isStaple,
      this.stockLevel = StockLevel.inStock});
}
