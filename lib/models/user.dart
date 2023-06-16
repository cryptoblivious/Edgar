import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgar/models/food_product.dart';
import 'package:edgar/models/pantry.dart';
import 'package:edgar/models/recipe.dart';

class User {
  String? uid;
  String? name;
  String? email;
  String? avatarURL;
  int? activePantry;
  List<Pantry>? pantries;
  List<Recipe>? recipes;
  List<FoodProduct>? watchList;
  List<FoodProduct>? shoppingList;
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
    pantries = [];
    recipes = [];
    watchList = [];
    shoppingList = [];
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
    }
  }
}
