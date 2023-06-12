import 'package:flutter/material.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/cards/pantry_item_card.dart';
import 'package:edgar/widgets/cards/add_items_to_pantry_card.dart';

class AddItemsToPantrySubscreen extends StatelessWidget {
  const AddItemsToPantrySubscreen({super.key, required this.user, required this.onItemAdded});

  final User user;
  final void Function(PantryItem) onItemAdded;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          Text('You are a potato', style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
    );
  }
}
