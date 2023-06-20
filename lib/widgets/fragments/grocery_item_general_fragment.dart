import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/food_product.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/dialogs/food_product_description_dialog.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class GroceryItemGeneralFragment extends StatefulWidget {
  const GroceryItemGeneralFragment({super.key, required this.foodProduct});

  final FoodProduct foodProduct;

  @override
  State<GroceryItemGeneralFragment> createState() => _GroceryItemGeneralFragmentState();
}

class _GroceryItemGeneralFragmentState extends State<GroceryItemGeneralFragment> {
  FoodProduct get foodProduct => widget.foodProduct;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => {
        HapticFeedback.selectionClick(),
        showGenericSnackbar(context, message: 'Long press to show product description.'),
      },
      onLongPress: () {
        HapticFeedback.selectionClick();
        showfoodProductDescriptionDialog(context, foodProduct);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          height: double.maxFinite,
          child: Row(
            children: [
              Tooltip(
                  textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onTertiary),
                  message: capitalize(foodProduct.mainCategory),
                  child: Icon(foodProduct.iconData, color: Theme.of(context).colorScheme.onTertiary, size: 36)),
              const SizedBox(width: 10),
              Expanded(
                child: AutoSizeText(
                  capitalize(foodProduct.name),
                  style: TextStyle(
                    fontSize: 36,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  maxLines: 1, // Restrict the text to a single line
                  overflow: TextOverflow.ellipsis, // Handle text overflow with ellipsis
                  minFontSize: 16, // Minimum font size
                  stepGranularity: 1, // Granularity for resizing the font size
                  wrapWords: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
