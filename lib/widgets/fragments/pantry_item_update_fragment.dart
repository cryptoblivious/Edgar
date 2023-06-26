import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/services/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/services/utils/string_utils.dart';

class PantryItemUpdateFragment extends StatefulWidget {
  const PantryItemUpdateFragment({
    Key? key,
    required this.pantryItem,
    required this.onItemUpdated,
  }) : super(key: key);

  final PantryItem pantryItem;
  final Function(PantryItem, String) onItemUpdated;

  @override
  State<PantryItemUpdateFragment> createState() => _PantryItemUpdateFragmentState();
}

class _PantryItemUpdateFragmentState extends State<PantryItemUpdateFragment> {
  PantryItem get pantryItem => widget.pantryItem;
  Function(PantryItem, String) get onItemUpdated => widget.onItemUpdated;
  bool isOnWatchlist = false;
  bool isInCookingPot = false;
  Map<Stock, IconData> stockLevelIcons = {
    Stock.ok: FontAwesomeIcons.hourglassStart,
    Stock.low: FontAwesomeIcons.hourglassHalf,
    Stock.out: FontAwesomeIcons.hourglassEnd
  };

  List<IconData> isStapleIcons = [
    Icons.question_mark,
    FontAwesomeIcons.arrowsRotate,
  ];

  List<IconData> isOnWatchlistIcons = [
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.magnifyingGlassDollar,
  ];

  List<IconData> isInCookingPotIcons = [
    FontAwesomeIcons.kitchenSet,
    FontAwesomeIcons.fireBurner,
  ];

  void _handleItemChanged(String variable) {
    setState(() {
      HapticFeedback.selectionClick();
      if (variable == 'isOnWatchlist') {
        isOnWatchlist = !isOnWatchlist;
      } else if (variable == 'isInCookingPot') {
        isInCookingPot = !isInCookingPot;
      }
    });
    onItemUpdated(pantryItem, variable);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
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
                Column(
                  children: [
                    IconButton(
                      icon: Icon(isStapleIcons[pantryItem.isStaple! ? 1 : 0]),
                      onPressed: () => _handleItemChanged('isStaple'),
                      color: Theme.of(context).colorScheme.onPrimary,
                      iconSize: 20,
                    ),
                    Text(pantryItem.isStaple! ? 'Staple' : 'Occasional', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                  ],
                ),
                Column(children: [
                  IconButton(
                    icon: Icon(stockLevelIcons[pantryItem.stock]),
                    onPressed: () => _handleItemChanged('stock'),
                    color: Theme.of(context).colorScheme.onPrimary,
                    iconSize: 24,
                  ),
                  Text(
                      pantryItem.stock == Stock.ok
                          ? 'In stock'
                          : pantryItem.stock == Stock.low
                              ? 'Low stock'
                              : 'Out of stock',
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                ]),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(isOnWatchlistIcons[isOnWatchlist ? 1 : 0]),
                      onPressed: () => _handleItemChanged('isOnWatchlist'),
                      color: Theme.of(context).colorScheme.onPrimary,
                      iconSize: 24,
                    ),
                    Text(isOnWatchlist ? 'Watching' : 'Watch', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                  ],
                ),
                Column(children: [
                  IconButton(
                    icon: Icon(isInCookingPotIcons[isInCookingPot ? 1 : 0]),
                    onPressed: () => _handleItemChanged('isInCookingPot'),
                    color: Theme.of(context).colorScheme.onPrimary,
                    iconSize: 24,
                  ),
                  Text(isInCookingPot ? 'Cooking' : 'Cook', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                ]),
              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                capitalize(pantryItem.foodProduct!.name),
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
