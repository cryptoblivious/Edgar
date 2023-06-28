import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgar/models/food_product.dart';
import 'package:edgar/models/pantry.dart';
import 'package:edgar/models/recipe.dart';
import 'package:edgar/models/shopping_list.dart';

class User {
  String? uid;
  String? name;
  String? email;
  String? avatarURL;
  int? activePantry;
  int? activeShoppingList;
  List<Pantry>? pantries;
  List<Recipe>? recipes;
  List<FoodProduct>? watchList;
  List<ShoppingList>? shoppingLists;
  List<String>? diets;
  List<FoodProduct>? specificAllergens;
  List<String>? broadAllergens;
  List<User>? friends;

  User();

  User._create(dynamic data) {
    uid = (data['uid'] ?? '') as String;
    name = (data['profile']['name'] ?? '') as String;
    email = (data['profile']['email'] ?? '') as String;
    avatarURL = (data['profile']['photoURL'] ?? '') as String;
    activePantry = (data['activePantry'] ?? 0) as int;
    activeShoppingList = (data['activeShoppingList'] ?? 0) as int;
    pantries = [];
    // TODO : Implement recipe book logic
    recipes = [];
    watchList = [];
    shoppingLists = [];
    diets = [];
    specificAllergens = [];
    broadAllergens = [];
    friends = [];
  }

  static Future<User> createAsync(DocumentSnapshot snapshot) async {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    User user = User._create(data);
    await user._loadFromFirestore(data);
    return user;
  }

  Future<void> _loadFromFirestore(dynamic data) async {
    if (data?.containsKey('pantries') == true && data?['pantries'] is List) {
      List<dynamic> pantriesData = (data?['pantries'] ?? []) as List<dynamic>;
      List<DocumentReference> pantryReferences = List<DocumentReference>.from(pantriesData);

      await Future.wait(
        pantryReferences.map((pantryRef) async {
          DocumentSnapshot pantrySnapshot = await pantryRef.get();
          Pantry pantry = await Pantry.createAsync(pantrySnapshot);
          return pantry; // Return the pantry object
        }),
      ).then((pantriesList) {
        pantries = pantriesList.toList(); // Collect the results into the pantries list
      });

      if (data?.containsKey('shoppingLists') == true && data?['shoppingLists'] is List) {
        List<dynamic> shoppingListsData = (data?['shoppingLists'] ?? []) as List<dynamic>;
        List<DocumentReference> shoppingListReferences = List<DocumentReference>.from(shoppingListsData);

        await Future.wait(
          shoppingListReferences.map((shoppingListRef) async {
            DocumentSnapshot shoppingListSnapshot = await shoppingListRef.get();
            ShoppingList shoppingList = await ShoppingList.createAsync(shoppingListSnapshot);
            return shoppingList; // Return the shopping list object
          }),
        ).then((shoppingListsList) {
          shoppingLists = shoppingListsList.toList(); // Collect the results into the shopping lists list
        });
      }
    }
  }
}
