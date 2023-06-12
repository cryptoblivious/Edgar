import 'package:flutter/material.dart';
import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';

class OwnedItemCards extends StatelessWidget {
  const OwnedItemCards({Key? key, required this.user, required this.onItemUpdated}) : super(key: key);

  final User user;
  final void Function(PantryItem, String) onItemUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: user.pantries![user.activePantry].items.length + 1,
      itemBuilder: (context, index) {
        if (index < user.pantries![user.activePantry].items.length) {
          return PantryItemCard(
            pantryItem: user.pantries![user.activePantry].items[index],
            onItemUpdated: onItemUpdated,
          );
        } else {
          return const SizedBox(height: 50);
        }
      },
    );
  }
}
