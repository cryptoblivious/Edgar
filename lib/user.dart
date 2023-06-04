import 'food_product.dart';
import 'pantry_item.dart';
import 'recipe.dart';

class User {
  List<PantryItem> pantry;
  List<Recipe> recipeBook;
  List<FoodProduct> watchList;
  List<FoodProduct> shoppingList;
  List<String> diets;
  List<FoodProduct> specificAllergens;
  List<String> broadAllergens;
  String? email;
  List<User>? friends;

  User(
      {this.pantry = const [],
      this.recipeBook = const [],
      this.watchList = const [],
      this.shoppingList = const [],
      this.diets = const [],
      this.specificAllergens = const [],
      this.broadAllergens = const [],
      this.email,
      this.friends});
}
