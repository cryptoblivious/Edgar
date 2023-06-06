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

  User._create(DocumentSnapshot snapshot) {
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
    User user = User._create(snapshot);
    await user._loadFromFirestore(snapshot);
    return user;
  }

  Future<void> _loadFromFirestore(DocumentSnapshot snapshot) async {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data?.containsKey('pantries') == true && data?['pantries'] is List) {
      List<dynamic> pantriesData = (data?['pantries'] ?? []) as List<dynamic>;
      List<DocumentReference> pantryReferences = List<DocumentReference>.from(pantriesData);

      await Future.wait(
        pantryReferences.map((pantryRef) async {
          DocumentSnapshot pantrySnapshot = await pantryRef.get();
          print('Pantry document data: ${pantrySnapshot.data()}');
          Pantry pantry = Pantry.fromFirestore(pantrySnapshot);
          pantries!.add(pantry);
        }),
      );
    }
  }
}
