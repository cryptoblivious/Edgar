import 'package:flutter/material.dart';

// TODO : Transform into sort button
class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  List<String> sortOptions = [
    'Name (A-Z)',
    'Name (Z-A)',
    'Stock (Low-High)',
    'Stock (High-Low)',
  ];
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
      message: 'Filter',
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
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
        ),
      ),
    );
  }
}
