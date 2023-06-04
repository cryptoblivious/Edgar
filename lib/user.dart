import 'food_product.dart';
import 'pantry_item.dart';

class User {
  List<PantryItem> pantryItems;
  List<FoodProduct> watchList;
  List<FoodProduct> shoppingList;
  List<String> diets;
  List<FoodProduct> specificAllergens;
  List<String> broadAllergens;
  String? email;
  User(
      {this.pantryItems = const [],
      this.watchList = const [],
      this.shoppingList = const [],
      this.diets = const [],
      this.specificAllergens = const [],
      this.broadAllergens = const [],
      this.email});
}
