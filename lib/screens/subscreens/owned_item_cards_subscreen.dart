import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';

class OwnedItemCardsSubscreen extends StatelessWidget {
  const OwnedItemCardsSubscreen({super.key, required this.user, required this.onItemUpdated, required this.onPressed});

  final void Function(PantryItem, String) onItemUpdated;
  final void Function() onPressed;

  final User user;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.primary,
    ));

    final sortedList = user.pantries![user.activePantry].items.map((pantryItem) => pantryItem).toList()
      ..sort((a, b) => a.foodProduct!.name.compareTo(b.foodProduct!.name));

    return Expanded(
      child: ListView(
        children: [
          ...sortedList
              .map((pantryItem) => PantryItemCard(
                    pantryItem: pantryItem,
                    onItemUpdated: onItemUpdated,
                  ))
              .toList(),
          AddToPantryPromptCard(onPressed: onPressed),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
