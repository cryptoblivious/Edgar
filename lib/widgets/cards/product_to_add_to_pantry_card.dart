import 'package:edgar/services/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:edgar/models/food_product.dart';
import 'package:edgar/widgets/dialogs/food_product_description_dialog.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class ProductToAddToPantryCard extends StatefulWidget {
  const ProductToAddToPantryCard({super.key, required this.foodProduct, required this.onItemAdded});

  final FoodProduct foodProduct;
  final Function(FoodProduct, bool) onItemAdded;

  @override
  State<ProductToAddToPantryCard> createState() => _ProductToAddToPantryCardState();
}

class _ProductToAddToPantryCardState extends State<ProductToAddToPantryCard> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () {
        HapticFeedback.selectionClick();
        showGenericSnackbar(context, message: 'Long press to see product description.');
      },
      onLongPress: () {
        HapticFeedback.selectionClick();
        showfoodProductDescriptionDialog(context, widget.foodProduct);
      },
      child: Dismissible(
        resizeDuration: const Duration(milliseconds: 1),
        key: UniqueKey(),
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.blue[800]!,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.cached,
                color: Theme.of(context).colorScheme.onError,
                size: 32,
              ),
              const SizedBox(width: 10),
              Text('Staple', style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 32)),
            ],
          ),
        ),
        secondaryBackground: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Occasional', style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 32)),
              const SizedBox(width: 10),
              Icon(
                Icons.question_mark,
                color: Theme.of(context).colorScheme.onError,
                size: 32,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            widget.onItemAdded(widget.foodProduct, false);
          } else if (direction == DismissDirection.startToEnd) {
            widget.onItemAdded(widget.foodProduct, true);
          }
        },
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Tooltip(
                      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                      message: capitalize(widget.foodProduct.mainCategory),
                      child: Icon(widget.foodProduct.iconData, color: Theme.of(context).colorScheme.onPrimary, size: 36),
                    ),
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
      ),
    );
  }
}
