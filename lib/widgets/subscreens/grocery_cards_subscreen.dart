import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/food_product.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';
import 'package:edgar/widgets/cards/grocery_item_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class GroceryCardsSubscreen extends StatefulWidget {
  GroceryCardsSubscreen({super.key, required this.user, required this.onPressed, required this.sortSetting});

  final User user;
  final void Function() onPressed;
  final String sortSetting;

  final DataRepository dataRepository = FirestoreRepository();

  @override
  State<GroceryCardsSubscreen> createState() => _GroceryCardsSubscreenState();
}

class _GroceryCardsSubscreenState extends State<GroceryCardsSubscreen> {
  void handleItemUpdated(FoodProduct foodProduct, String operation) {
    List<String> userActivePantryFoodProductNames =
        widget.user.pantries![widget.user.activePantry!].items.map((pantryItem) => pantryItem.foodProduct!.name).toList();

    setState(() {
      if (userActivePantryFoodProductNames.contains(foodProduct.name)) {
        PantryItem changingItem =
            widget.user.pantries![widget.user.activePantry!].items.where((element) => element.foodProduct!.name == foodProduct.name).first;
        if (operation == 'addAsStaple') {
          changingItem.isStaple = true;
        } else if (operation == 'addAsOccasional') {
          changingItem.isStaple = false;
        }
        if (operation != 'removeFromShoppingList') {
          changingItem.stock = Stock.ok;
        }
      } else if (operation == 'addAsStaple') {
        widget.user.pantries![widget.user.activePantry!].addItem(PantryItem(foodProduct: foodProduct, isStaple: true));
      } else if (operation == 'addAsOccasional') {
        widget.user.pantries![widget.user.activePantry!].addItem(PantryItem(foodProduct: foodProduct, isStaple: false));
      }
      widget.user.shoppingLists![widget.user.activeShoppingList!].removeItem(foodProduct);
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
    widget.dataRepository.updateData({'object': widget.user.shoppingLists![widget.user.activeShoppingList!]});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.secondary,
    ));
    final sortedList = widget.user.shoppingLists![widget.user.activeShoppingList!].items;

    final Map<String, void Function()> sortOptions = {
      'name': () {
        sortedList.sort((a, b) => a.name.compareTo(b.name));
      },
      'nameInverted': () {
        sortedList.sort((a, b) => b.name.compareTo(a.name));
      },
    };

    if (sortOptions.containsKey(widget.sortSetting)) {
      sortOptions[widget.sortSetting]?.call();
    }

    return Expanded(
      child: ListView(
        cacheExtent: 9999,
        children: [
          ...sortedList
              .map((foodProduct) => GroceryItemCard(
                    key: ValueKey(foodProduct.uid),
                    foodProduct: foodProduct,
                    onItemUpdated: handleItemUpdated,
                  ))
              .toList(),
          PromptCard(onPressed: widget.onPressed, message: 'Add more items to your shopping list!'),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
