import 'package:flutter/material.dart';

import 'package:edgar/widgets/list_views/owned_item_cards.dart';
import 'package:edgar/widgets/cards/add_items_to_pantry_card.dart';

import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/user.dart';

class OwnedItemsSubscreen extends StatelessWidget {
  const OwnedItemsSubscreen({super.key, required this.user, required this.onItemUpdated, required this.onPressed});

  final User user;
  final Function(PantryItem, String) onItemUpdated;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //OwnedItemCards(user: user, onItemUpdated: onItemUpdated),
        AddItemsToPantryCard(onPressed: onPressed),
      ],
    );
  }
}
