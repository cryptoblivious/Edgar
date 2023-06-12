import 'package:flutter/material.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/widgets/cards/add_items_to_pantry_card.dart';

class OwnedItemCardsSubscreen extends StatelessWidget {
  const OwnedItemCardsSubscreen({super.key, required this.user, required this.onItemUpdated, required this.onPressed});

  final User user;
  final void Function(PantryItem, String) onItemUpdated;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...user.pantries![user.activePantry].items
              .map((pantryItem) => PantryItemCard(
                    pantryItem: pantryItem,
                    onItemUpdated: onItemUpdated,
                  ))
              .toList(),
          AddItemsToPantryCard(onPressed: onPressed),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
