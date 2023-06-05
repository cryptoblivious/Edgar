import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_product.dart';
import 'pantry.dart';
import 'recipe.dart';

class User {
  int? activePantry = 0;
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
    this.friends,
  });

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    User user = User(email: data?['email'] as String?);

    // Check if the 'pantry' field exists and is a subcollection
    if (snapshot.reference.collection('pantry') != null) {
      CollectionReference pantryCollectionRef = snapshot.reference.collection('pantry');

      // Query the subcollection to retrieve documents
      pantryCollectionRef.get().then((pantryQuerySnapshot) {
        print('Pantry subcollection snapshot: $pantryQuerySnapshot');
        // Iterate through the documents in the subcollection
        for (DocumentSnapshot pantrySnapshot in pantryQuerySnapshot.docs) {
          if (pantrySnapshot.exists) {
            print('Pantry document snapshot exists');
            // Process each pantry document here
            // Example: user.pantryList.add(Pantry.fromFirestore(pantrySnapshot));
          } else {
            print('Pantry document snapshot does not exist');
            // Handle the case where a pantry document doesn't exist
          }
        }
        print('Pantry: ${user.pantries?[0]}');
      }).catchError((error) {
        print('Error retrieving pantry subcollection: $error');

        // Handle any error that occurred while retrieving the pantry subcollection
      });
    } else {
      // Handle the case where the 'pantry' subcollection is missing
    }

    // Continue processing other user data fields if needed

    print('user : $user');
    return user;
  }
}
