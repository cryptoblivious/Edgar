import 'package:edgar/models/food_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class GroceryItemRemoveFragment extends StatefulWidget {
  const GroceryItemRemoveFragment({
    Key? key,
    required this.foodProduct,
    required this.onLongPress,
  }) : super(key: key);

  final FoodProduct foodProduct;
  final Function(FoodProduct, String) onLongPress;

  @override
  State<GroceryItemRemoveFragment> createState() => _GroceryItemRemoveFragmentState();
}

class _GroceryItemRemoveFragmentState extends State<GroceryItemRemoveFragment> {
  FoodProduct get foodProduct => widget.foodProduct;
  Function(FoodProduct, String) get onLongPress => widget.onLongPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => {
        HapticFeedback.selectionClick(),
        showGenericSnackbar(context, message: 'Long press to remove item from shopping list.'),
      },
      onLongPress: () => onLongPress(foodProduct, 'removeFromShoppingList'),
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
              capitalize(foodProduct.name),
              maxLines: 1,
              style: TextStyle(fontSize: 36, color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
