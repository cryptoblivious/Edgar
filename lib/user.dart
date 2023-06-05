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
    try {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      User user = User(email: data?['email'] as String?);

      // Retrieve the user's pantries in a method
      user._setPantries(snapshot);

      // Continue processing other user data fields if needed

      print('user: $user');
      return user;
    } catch (error) {
      print('Error retrieving user: $error');
      return User();
    }
  }

  Future<void> _setPantries(DocumentSnapshot snapshot) async {
    CollectionReference pantriesCollectionRef = snapshot.reference.collection('pantries');
    print('Pantry subcollection reference: $pantriesCollectionRef');
    print('Pantry subcollection path: ${pantriesCollectionRef.path}');
    DocumentReference pantryDocumentRef = pantriesCollectionRef.doc('kwLJoVwZkG4VMWEMZl1M');
    DocumentSnapshot pantryDocumentSnapshot = await pantryDocumentRef.get().then((DocumentSnapshot snapshot) {
      print('Pantry document snapshot: $snapshot');
      return snapshot;
    });
    print(pantryDocumentSnapshot);
// TODO : Find out why this isn't working
    await pantriesCollectionRef.get().then(
      (querySnapshot) {
        print('Pantry subcollection snapshot: $querySnapshot');
        for (final DocumentSnapshot pantrySnapshot in querySnapshot.docs) {
          if (pantrySnapshot.exists) {
            print('Pantry document snapshot exists');
            pantries?.add(Pantry.fromFirestore(pantrySnapshot));
          } else {
            print('Pantry document snapshot does not exist');
            // Handle the case where a pantry document doesn't exist
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
