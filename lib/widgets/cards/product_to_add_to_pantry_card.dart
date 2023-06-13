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
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[800]!,
            borderRadius: BorderRadius.circular(10),
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(10),
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
            // Handle swipe from right to left
            // Show explanation for deleting
          } else if (direction == DismissDirection.startToEnd) {
            // Handle swipe from left to right
            // Show explanation for checking
          }
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(10),
          ),
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
