import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/food_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class GroceryItemUpdateFragment extends StatefulWidget {
  const GroceryItemUpdateFragment({
    Key? key,
    required this.foodProduct,
    required this.onItemUpdated,
  }) : super(key: key);

  final FoodProduct foodProduct;
  final Function(FoodProduct, String) onItemUpdated;

  @override
  State<GroceryItemUpdateFragment> createState() => _GroceryItemUpdateFragmentState();
}

class _GroceryItemUpdateFragmentState extends State<GroceryItemUpdateFragment> {
  FoodProduct get foodProduct => widget.foodProduct;
  Function(FoodProduct, String) get onItemUpdated => widget.onItemUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          color: Theme.of(context).colorScheme.primary),
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => {
                    HapticFeedback.selectionClick(),
                    showGenericSnackbar(context, message: 'Long press to add as an occasional item.'),
                  },
                  onLongPress: () => onItemUpdated(foodProduct, 'addAsOccasional'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.question_mark,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      ),
                      Text('Occasional', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    HapticFeedback.selectionClick(),
                    showGenericSnackbar(context, message: 'Long press to add as a staple item.'),
                  },
                  onLongPress: () => onItemUpdated(foodProduct, 'addAsStaple'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      ),
                      Text('Staple', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                capitalize(foodProduct.name),
                maxLines: 2,
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
