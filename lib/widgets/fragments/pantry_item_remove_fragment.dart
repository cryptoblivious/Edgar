import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class PantryItemRemoveFragment extends StatefulWidget {
  const PantryItemRemoveFragment({
    Key? key,
    required this.pantryItem,
    required this.onLongPress,
  }) : super(key: key);

  final PantryItem pantryItem;
  final Function(PantryItem) onLongPress;

  @override
  State<PantryItemRemoveFragment> createState() => _PantryItemRemoveFragmentState();
}

class _PantryItemRemoveFragmentState extends State<PantryItemRemoveFragment> {
  PantryItem get pantryItem => widget.pantryItem;
  Function(PantryItem) get onLongPress => widget.onLongPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => showGenericSnackbar(context, message: 'Long press to remove item from pantry.'),
      onLongPress: () => onLongPress(pantryItem),
      child: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          color: Theme.of(context).colorScheme.errorContainer,
        ),
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Icon(Icons.delete_forever_rounded, size: 36, color: Theme.of(context).colorScheme.error),
            AutoSizeText(
              capitalize(pantryItem.foodProduct!.name),
              maxLines: 1,
              style: TextStyle(fontSize: 36, color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
