import 'food_product.dart';

class Ingredient {
  FoodProduct foodProduct;
  double quantity;
  List<Ingredient> substitutes;
  String? preparation;
  String? unit;

  Ingredient({
    required this.foodProduct,
    required this.quantity,
    this.substitutes = const [],
    this.preparation,
    this.unit,
  });
}
