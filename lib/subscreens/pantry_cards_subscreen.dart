import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class PantryCardsSubscreen extends StatefulWidget {
  PantryCardsSubscreen({super.key, required this.user, required this.onPressed, required this.sortSetting});

  final User user;
  final void Function() onPressed;
  final String sortSetting;

  final DataRepository dataRepository = FirestoreRepository();

  @override
  State<PantryCardsSubscreen> createState() => _PantryCardsSubscreenState();
}

class _PantryCardsSubscreenState extends State<PantryCardsSubscreen> {
  final ScrollController _scrollController = ScrollController();
  List<PantryItem> sortedList = [];

  @override
  void initState() {
    super.initState();
    sortList();
  }

  void sortList() {
    // Sort the list based on the selected sort option
    sortedList = widget.user.pantries![widget.user.activePantry!].items.map((pantryItem) => pantryItem).toList();

    final Map<String, void Function()> sortOptions = {
      'name': () {
        sortedList.sort((a, b) => a.foodProduct!.name.compareTo(b.foodProduct!.name));
      },
      'nameInverted': () {
        sortedList.sort((a, b) => b.foodProduct!.name.compareTo(a.foodProduct!.name));
      },
      'stock': () {
        sortedList.sort((a, b) {
          // Compare by stock level first
          int stockComparison = a.stock!.index.compareTo(b.stock!.index);
          if (stockComparison != 0) {
            return stockComparison;
          }
          // If stock level is the same, compare by name
          return a.foodProduct!.name.compareTo(b.foodProduct!.name);
        });
      },
      'stockInverted': () {
        sortedList.sort((a, b) {
          // Compare by stock level first
          int stockComparison = b.stock!.index.compareTo(a.stock!.index);
          if (stockComparison != 0) {
            return stockComparison;
          }
          // If stock level is the same, compare by name
          return a.foodProduct!.name.compareTo(b.foodProduct!.name);
        });
      },
    };

    // Apply the selected sort option
    if (sortOptions.containsKey(widget.sortSetting)) {
      sortOptions[widget.sortSetting]?.call();
    }
  }

  void scrollToActiveCard(PantryItem activeItem) {
    final index = sortedList.indexOf(activeItem);
    if (index != -1) {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        final itemPosition = renderObject.localToGlobal(Offset.zero).dy + (index * 75); // Replace ITEM_HEIGHT with the actual height of the item
        final viewportHeight = MediaQuery.of(context).size.height;
        final scrollOffset = _scrollController.offset;

        // Check if the item is within the visible range
        if (itemPosition < scrollOffset || itemPosition > scrollOffset + viewportHeight) {
          _scrollController.animateTo(
            index * 75,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  void handleItemUpdated(PantryItem pantryItem, String variable) {
    PantryItem changingItem =
        widget.user.pantries![widget.user.activePantry!].items.where((element) => element.foodProduct!.name == pantryItem.foodProduct!.name).first;
    setState(() {
      changingItem.change(variable);
    });
    if (variable == 'stock') {
      if (changingItem.stock == Stock.ok) {
        if (widget.user.shoppingLists![widget.user.activeShoppingList!].containsItem(changingItem.foodProduct!)) {
          widget.user.shoppingLists![widget.user.activeShoppingList!].removeItem(changingItem.foodProduct!);
          widget.dataRepository.updateData({'object': widget.user.shoppingLists![widget.user.activeShoppingList!]});
        }
      } else if (changingItem.isStaple == true && !widget.user.shoppingLists![widget.user.activeShoppingList!].containsItem(changingItem.foodProduct!)) {
        widget.user.shoppingLists![widget.user.activeShoppingList!].addItem(changingItem.foodProduct!);
        widget.dataRepository.updateData({'object': widget.user.shoppingLists![widget.user.activeShoppingList!]});
      }
    }
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});

    sortList(); // Call sortList method to update the sortedList
    scrollToActiveCard(changingItem); // Scroll to the position of the active card
  }

  void handleItemRemoved(PantryItem pantryItem) {
    setState(() {
      widget.user.pantries![widget.user.activePantry!].removeItem(pantryItem);
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
    sortList(); // Call sortList method to update the sortedList
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    return Expanded(
      child: ListView(
        controller: _scrollController,
        cacheExtent: 9999,
        children: [
          ...sortedList
              .map((pantryItem) => PantryItemCard(
                    key: ValueKey(pantryItem.foodProduct!.uid),
                    pantryItem: pantryItem,
                    onItemUpdated: handleItemUpdated,
                    onItemRemoved: handleItemRemoved,
                  ))
              .toList(),
          PromptCard(
            onPressed: widget.onPressed,
            message: 'Add more items to your pantry!',
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
