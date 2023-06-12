import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/stock.dart';

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

  void _showPantryItemDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            pantryItem.foodProduct!.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondaryContainer),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
              child: Text(
            pantryItem.foodProduct!.description,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.justify,
          )),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  // Perform an action when the button is pressed
                  Navigator.of(context).pop();
                },
                child: const Text('Good to know!', style: TextStyle(fontSize: 32)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        _showPantryItemDialog(context);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            color: Theme.of(context).colorScheme.primary,
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
                      message: pantryItem.foodProduct!.icon,
                      child: Icon(pantryItem.foodProduct!.iconData, color: Theme.of(context).colorScheme.onPrimary, size: 36)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AutoSizeText(
                      pantryItem.foodProduct!.name,
                      style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      maxLines: 2, // Restrict the text to a single line
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
                    iconSize: 32,
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
                      iconSize: 32,
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
                    iconSize: 32,
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
