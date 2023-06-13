import 'package:edgar/models/food_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/dialogs/food_product_description_dialog.dart';

class PantryItemCard extends StatefulWidget {
  const PantryItemCard({super.key, required this.pantryItem, required this.onItemUpdated});

  final PantryItem pantryItem;
  final Function(PantryItem, String) onItemUpdated;

  @override
  State<PantryItemCard> createState() => _PantryItemCardState();
}

class _PantryItemCardState extends State<PantryItemCard> {
  PantryItem get pantryItem => widget.pantryItem;
  Function(PantryItem, String) get onItemUpdated => widget.onItemUpdated;
  bool isOnWatchlist = false;
  Map<Stock, IconData> stockLevelIcons = {
    Stock.ok: FontAwesomeIcons.hourglassStart,
    Stock.low: FontAwesomeIcons.hourglassHalf,
    Stock.out: FontAwesomeIcons.hourglassEnd
  };

  List<IconData> isStapleIcons = [
    FontAwesomeIcons.triangleExclamation,
    FontAwesomeIcons.arrowsRotate,
  ];

  List<IconData> isOnWatchlistIcons = [
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.magnifyingGlassDollar,
  ];

  void _handleItemChanged(String variable) {
    setState(() {
      HapticFeedback.selectionClick();
      if (variable == 'isOnWatchlist') {
        isOnWatchlist = !isOnWatchlist;
      }
    });
    onItemUpdated(pantryItem, variable);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => HapticFeedback.selectionClick(),
      onLongPress: () {
        HapticFeedback.selectionClick();
        showfoodProductDescriptionDialog(context, pantryItem.foodProduct!);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Tooltip(
                      textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                      message: capitalize(pantryItem.foodProduct!.mainCategory),
                      child: Icon(pantryItem.foodProduct!.iconData, color: Theme.of(context).colorScheme.onPrimary, size: 36)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AutoSizeText(
                      capitalize(pantryItem.foodProduct!.name),
                      style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      maxLines: 3, // Restrict the text to a single line
                      overflow: TextOverflow.ellipsis, // Handle text overflow with ellipsis
                      minFontSize: 16, // Minimum font size
                      stepGranularity: 1, // Granularity for resizing the font size
                      wrapWords: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Tooltip(
                  textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                  message: pantryItem.isStaple! ? 'Remove staple' : 'Add staple',
                  child: IconButton(
                    icon: Icon(isStapleIcons[pantryItem.isStaple! ? 1 : 0]),
                    onPressed: () => _handleItemChanged('isStaple'),
                    color: Theme.of(context).colorScheme.onPrimary,
                    iconSize: 24,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Tooltip(
                    textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                    message: isOnWatchlist ? 'Remove from watchlist' : 'Add to watchlist',
                    child: IconButton(
                      icon: Icon(isOnWatchlistIcons[isOnWatchlist ? 1 : 0]),
                      onPressed: () => _handleItemChanged('isOnWatchlist'),
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      iconSize: 24,
                    ),
                  ),
                ),
                Tooltip(
                  textStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onPrimary),
                  message: pantryItem.stock == Stock.ok
                      ? 'In stock'
                      : pantryItem.stock == Stock.low
                          ? 'Low stock'
                          : 'Out of stock',
                  child: IconButton(
                    icon: Icon(stockLevelIcons[pantryItem.stock]),
                    onPressed: () => _handleItemChanged('stock'),
                    color: Theme.of(context).colorScheme.onPrimary,
                    iconSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
