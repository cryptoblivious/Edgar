import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PromptCard extends StatelessWidget {
  const PromptCard({super.key, required this.onPressed, this.message = 'Prompt card'});

  final Function() onPressed;
  final String message;

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
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onTertiary),
            ),
          )),
    );
  }
}
