import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
      message: 'Filter',
      child: IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () {
          // TODO : Implement filter options
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
    );
  }
}
