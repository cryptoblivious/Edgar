import 'package:edgar/widgets/placeholders/screen_ph.dart';
import 'package:flutter/material.dart';

import 'package:edgar/models/user.dart';
import 'package:edgar/models/pantry_item.dart';

import 'package:edgar/widgets/placeholders/screen_ph.dart';

class AddItemsToPantrySubscreen extends StatelessWidget {
  const AddItemsToPantrySubscreen({super.key, required this.user, required this.onItemAdded});

  final User user;
  final void Function(PantryItem) onItemAdded;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: const [
        ScreenPlaceholder(name: 'You are a potato!'),
      ]),
    );
  }
}
