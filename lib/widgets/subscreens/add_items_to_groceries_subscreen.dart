import 'package:edgar/models/food_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/widgets/cards/product_to_add_to_groceries_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class AddItemsToGroceriesSubscreen extends ConsumerStatefulWidget {
  AddItemsToGroceriesSubscreen({super.key, required this.user, required this.foodProducts});

  final User user;
  final List<FoodProduct> foodProducts;
  final DataRepository dataRepository = FirestoreRepository();

  @override
  AddItemsToPantrySubscreenState createState() => AddItemsToPantrySubscreenState();
}

class AddItemsToPantrySubscreenState extends ConsumerState<AddItemsToGroceriesSubscreen> {
  List<FoodProduct>? sortedList;
  late List<String> userGroceriesFoodProductNames;

  void handleItemAdded(FoodProduct foodProduct) {
    setState(() {
      widget.user.shoppingLists![widget.user.activeShoppingList!].addItem(foodProduct);
    });
    widget.dataRepository.updateData({'object': widget.user.shoppingLists![widget.user.activeShoppingList!]});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.tertiary,
    ));

    userGroceriesFoodProductNames = widget.user.shoppingLists![widget.user.activeShoppingList!].items.map((foodProduct) => foodProduct.name).toList();
    sortedList = widget.foodProducts.map((foodProduct) => foodProduct).where((a) => !userGroceriesFoodProductNames.contains(a.name)).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return Expanded(
      child: ListView(
        children: [
          ...sortedList!
              .map((foodProduct) => ProductToAddToGroceriesCard(
                    foodProduct: foodProduct,
                    onItemAdded: handleItemAdded,
                  ))
              .toList(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
