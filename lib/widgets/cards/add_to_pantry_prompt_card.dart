import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddToPantryPromptCard extends StatelessWidget {
  const AddToPantryPromptCard({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        HapticFeedback.selectionClick();
        onPressed();
      },
      child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              border: Border.all(
                color: Theme.of(context).colorScheme.onTertiary,
              )),
          child: Center(
            child: Text(
              'Add more items to your pantry!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onTertiary),
            ),
          )),
    );
  }
}
