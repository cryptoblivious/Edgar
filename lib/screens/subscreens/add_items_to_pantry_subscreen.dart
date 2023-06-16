import 'package:edgar/models/food_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/product_to_add_to_pantry_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class AddItemsToPantrySubscreen extends ConsumerStatefulWidget {
  AddItemsToPantrySubscreen({super.key, required this.user, required this.foodProducts});

  final User user;
  final List<FoodProduct> foodProducts;
  final DataRepository dataRepository = FirestoreRepository();

  @override
  AddItemsToPantrySubscreenState createState() => AddItemsToPantrySubscreenState();
}

class AddItemsToPantrySubscreenState extends ConsumerState<AddItemsToPantrySubscreen> {
  List<FoodProduct>? sortedList;
  late List<String> userFoodProductNames;

  void handleItemAdded(FoodProduct foodProduct, bool isStaple) {
    setState(() {
      widget.user.pantries![widget.user.activePantry!].addItem(PantryItem(
        foodProduct: foodProduct,
        isStaple: isStaple,
      ));
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.tertiary,
    ));

    userFoodProductNames = widget.user.pantries![widget.user.activePantry!].items.map((pantryItem) => pantryItem.foodProduct!.name).toList();
    sortedList = widget.foodProducts.map((foodProduct) => foodProduct).where((a) => !userFoodProductNames.contains(a.name)).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return Expanded(
      child: ListView(
        children: [
          ...sortedList!
              .map((foodProduct) => ProductToAddToPantryCard(
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
