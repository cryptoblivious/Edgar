import 'package:edgar/models/food_product.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/services/providers/food_products.dart';
import 'package:edgar/screens/subscreens/loading_subscreen.dart';
import 'package:edgar/widgets/cards/product_to_add_to_pantry_card.dart';

class AddItemsToPantrySubscreen extends ConsumerStatefulWidget {
  const AddItemsToPantrySubscreen({super.key, required this.user, required this.foodProducts, required this.onItemAdded});

  final User user;
  final List<FoodProduct> foodProducts;
  final void Function(PantryItem) onItemAdded;

  @override
  AddItemsToPantrySubscreenState createState() => AddItemsToPantrySubscreenState();
}

class AddItemsToPantrySubscreenState extends ConsumerState<AddItemsToPantrySubscreen> {
  List<FoodProduct>? sortedList;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.tertiary,
    ));
    sortedList = widget.foodProducts.map((pantryItem) => pantryItem).toList()..sort((a, b) => a.name.compareTo(b.name));
    return Expanded(
      child: ListView(
        children: [
          ...sortedList!
              .map((foodProduct) => ProductToAddToPantryCard(
                    foodProduct: foodProduct,
                  ))
              .toList(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
