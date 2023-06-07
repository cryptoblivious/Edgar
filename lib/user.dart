import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_product.dart';
import 'pantry.dart';
import 'recipe.dart';

class User {
  Pantry pantry = Pantry();
  int activePantry = 0;
  List<Pantry>? pantries;
  List<Recipe>? recipes = [];
  List<FoodProduct>? watchList = [];
  List<FoodProduct>? shoppingList = [];
  List<String>? diets = [];
  List<FoodProduct>? specificAllergens = [];
  List<String>? broadAllergens = [];
  String? email;
  List<User>? friends;

  User({
    this.email,
  });

  User._create(dynamic data) {
    activePantry = (data['activePantry'] ?? 0) as int;
    pantries = [];
    recipes = [];
    watchList = [];
    shoppingList = [];
    diets = [];
    specificAllergens = [];
    broadAllergens = [];
    friends = [];
    email = '';
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
          print('Pantry document data: ${pantrySnapshot.data()}');
          Pantry pantry = await Pantry.createAsync(pantrySnapshot);
          return pantry; // Return the pantry object
        }),
      ).then((pantriesList) {
        pantries = pantriesList.toList(); // Collect the results into the pantries list
      });
    }
  }
}
