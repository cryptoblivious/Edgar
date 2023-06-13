import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:edgar/models/food_product.dart';
import 'package:edgar/widgets/dialogs/food_product_description_dialog.dart';
import 'package:edgar/services/utils/string_utils.dart';

class ProductToAddToPantryCard extends StatefulWidget {
  const ProductToAddToPantryCard({super.key, required this.foodProduct});

  final FoodProduct foodProduct;

  @override
  State<ProductToAddToPantryCard> createState() => _ProductToAddToPantryCardState();
}

class _ProductToAddToPantryCardState extends State<ProductToAddToPantryCard> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => HapticFeedback.selectionClick(),
      onLongPress: () {
        HapticFeedback.selectionClick();
        showfoodProductDescriptionDialog(context, widget.foodProduct);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Tooltip(
                      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                      message: capitalize(widget.foodProduct.mainCategory),
                      child: Icon(widget.foodProduct.iconData, color: Theme.of(context).colorScheme.onPrimary, size: 36)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AutoSizeText(
                      capitalize(widget.foodProduct.name),
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
          ],
        ),
      ),
    );
  }
}
