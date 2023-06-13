import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddToPantryPromptCard extends StatelessWidget {
  const AddToPantryPromptCard({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        onPressed();
      },
      child: Container(
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer,
              )),
          child: Center(
            child: Text(
              'Add more items to your pantry!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          )),
    );
  }
}
