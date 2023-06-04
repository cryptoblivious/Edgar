import 'food_product.dart';
import 'pantry.dart';
import 'recipe.dart';

class User {
  Pantry pantry = Pantry();
  List<Recipe> recipeBook = [];
  List<FoodProduct> watchList = [];
  List<FoodProduct> shoppingList = [];
  List<String> diets = [];
  List<FoodProduct> specificAllergens = [];
  List<String> broadAllergens = [];
  String? email;
  List<User>? friends;

  User({
    this.email,
  });
}
