import 'ingredient.dart';
import 'diet.dart';

class Recipe {
  String name;
  String cuisine;
  bool isSpicy;
  bool isFavorite;
  String description;
  int servings;
  int prepTime;
  int cookTime;
  int totalTime;
  List<Diet> diets;
  List<Ingredient> ingredients;
  List<String> steps;
  String? image;

  Recipe(
      {required this.name,
      required this.cuisine,
      required this.isSpicy,
      required this.isFavorite,
      required this.description,
      required this.servings,
      required this.prepTime,
      required this.cookTime,
      required this.diets,
      required this.ingredients,
      required this.steps,
      this.image})
      : totalTime = prepTime + cookTime;
}
