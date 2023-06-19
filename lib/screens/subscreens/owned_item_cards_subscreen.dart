import 'package:edgar/models/pantry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/fragments/pantry_item_general_fragment.dart';
import 'package:edgar/widgets/cards/add_to_pantry_prompt_card.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/services/database/data_repository.dart';
import 'package:edgar/services/database/firestore_repository.dart';

class OwnedItemCardsSubscreen extends StatefulWidget {
  OwnedItemCardsSubscreen({super.key, required this.user, required this.onPressed});

  final void Function() onPressed;

  final User user;

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
  }

  void handleItemRemoved(PantryItem pantryItem) {
    setState(() {
      widget.user.pantries![widget.user.activePantry!].removeItem(pantryItem);
    });
    widget.dataRepository.updateData({'object': widget.user.pantries![widget.user.activePantry!]});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    final sortedList = widget.user.pantries![widget.user.activePantry!].items.map((pantryItem) => pantryItem).toList()
      ..sort((a, b) => a.foodProduct!.name.compareTo(b.foodProduct!.name));

    return Expanded(
      child: ListView(
        children: [
          ...sortedList
              .map((pantryItem) => PantryItemCard(
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
