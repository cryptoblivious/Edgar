import 'package:flutter/material.dart';

class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(fontSize: 48, color: Theme.of(context).colorScheme.onSecondaryContainer),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
