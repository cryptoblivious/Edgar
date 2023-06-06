import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_product.dart';
import 'pantry.dart';
import 'recipe.dart';

class User {
  Pantry pantry = Pantry();
  int activePantry = 0;
  List<Pantry>? pantries = [];
  List<Recipe>? recipeBook = [];
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

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    User user = User(email: data?['email'] as String?);

    if (data?.containsKey('pantries') == true && data?['pantries'] is List) {
      List<dynamic> pantriesData = (data?['pantries'] ?? []) as List<dynamic>;
      List<DocumentReference> pantryReferences = pantriesData.cast<DocumentReference>();

      // Add a method to asynchronously fetch and process pantry documents
      Future<void> fetchPantries() async {
        for (final DocumentReference pantryRef in pantryReferences) {
          DocumentSnapshot pantrySnapshot = await pantryRef.get();
          if (pantrySnapshot.exists) {
            print('Pantry document data: ${pantrySnapshot.data()}');
            // Process each pantry document here
            // TODO : Add correct code in the Pantry firestore database
            Pantry pantry = Pantry.fromFirestore(pantrySnapshot);
            user.pantries!.add(pantry);
          } else {
            // Handle the case where the document was not found
            print('Pantry document not found');
          }
        }
      }

      // Call the asynchronous method to fetch and process pantry documents
      fetchPantries().catchError((error) {
        // Handle any error that occurred while fetching pantry documents
        print('Error fetching pantry documents: $error');
      });
    } else {
      // Handle the case where the 'pantries' field is missing or not an array
    }

    // Continue processing other user data fields if needed

    return user;
  }
}
