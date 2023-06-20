import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class OwnedItemCardsSubscreen extends StatefulWidget {
  OwnedItemCardsSubscreen({super.key, required this.user, required this.onPressed, required this.sortSetting});

  final User user;
  final void Function() onPressed;
  final String sortSetting;

  final DataRepository dataRepository = FirestoreRepository();

  @override
  State<OwnedItemCardsSubscreen> createState() => _OwnedItemCardsSubscreenState();
}

class _OwnedItemCardsSubscreenState extends State<OwnedItemCardsSubscreen> {
  void handleItemUpdated(PantryItem pantryItem, String variable) {
    setState(() {
      widget.user.pantries![widget.user.activePantry!].changeItem(pantryItem, variable);
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
    if (widget.user.pantries![widget.user.activePantry!].checkAddToShoppingList(pantryItem)) {
      if (!widget.user.shoppingLists![widget.user.activeShoppingList!].items.contains(pantryItem.foodProduct)) {
        widget.user.shoppingLists![widget.user.activeShoppingList!].addItem(pantryItem.foodProduct!);
        widget.dataRepository.updateData({'object': widget.user.shoppingLists![widget.user.activeShoppingList!]});
      }
    }
  }

  void handleItemRemoved(PantryItem pantryItem) {
    setState(() {
      widget.user.pantries![widget.user.activePantry!].removeItem(pantryItem);
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
  }

  @override
  Widget build(BuildContext context) {
    final sortedList = widget.user.pantries![widget.user.activePantry!].items.map((pantryItem) => pantryItem).toList();

    final Map<String, void Function()> sortOptions = {
      'name': () {
        sortedList.sort((a, b) => a.foodProduct!.name.compareTo(b.foodProduct!.name));
      },
      'nameInverted': () {
        sortedList.sort((a, b) => b.foodProduct!.name.compareTo(a.foodProduct!.name));
      },
      'stock': () {
        sortedList.sort((a, b) => a.stock!.index.compareTo(b.stock!.index));
      },
      'stockInverted': () {
        sortedList.sort((a, b) => b.stock!.index.compareTo(a.stock!.index));
      },
    };

    // TODO : Find how to make it so the sorting order only changes when this widget is removed
    if (sortOptions.containsKey(widget.sortSetting)) {
      sortOptions[widget.sortSetting]?.call();
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    return Expanded(
      child: ListView(
        children: [
          ...sortedList
              .map((pantryItem) => PantryItemCard(
                    key: ValueKey(pantryItem.foodProduct!.uid),
                    pantryItem: pantryItem,
                    onItemUpdated: handleItemUpdated,
                    onItemRemoved: handleItemRemoved,
                  ))
              .toList(),
          AddToPantryPromptCard(onPressed: widget.onPressed),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
