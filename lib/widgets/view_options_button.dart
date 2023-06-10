import 'package:flutter/material.dart';

class ViewOptionsButton extends StatelessWidget {
  const ViewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
      message: 'View Options',
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: IconButton(
          icon: const Icon(Icons.view_list_outlined),
          onPressed: () {
            // TODO : Implement view options
            null;
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.secondaryContainer),
            foregroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.onSecondaryContainer),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
