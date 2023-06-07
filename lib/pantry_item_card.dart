import 'package:flutter/material.dart';

import 'pantry_item.dart';
import 'stock.dart';

class PantryItemCard extends StatefulWidget {
  const PantryItemCard({super.key, required this.pantryItem, required this.onItemChanged});

  final PantryItem pantryItem;
  final Function(PantryItem) onItemChanged;

  @override
  State<PantryItemCard> createState() => _PantryItemCardState();
}

class _PantryItemCardState extends State<PantryItemCard> {
  PantryItem get pantryItem => widget.pantryItem;
  Function(PantryItem) get onItemChanged => widget.onItemChanged;

  Map<Stock, IconData> stockLevelIcons = {Stock.ok: Icons.hourglass_full, Stock.low: Icons.hourglass_bottom, Stock.out: Icons.hourglass_empty};

  List<IconData> isStapleIcons = [
    Icons.favorite_border,
    Icons.favorite,
  ];

  void _handleItemChanged(String variable) {
    setState(() {
      if (variable == 'isStaple') {
        pantryItem.isStaple = !pantryItem.isStaple!;
      } else if (variable == 'stockLevel') {
        switch (pantryItem.stock) {
          case Stock.in:
            pantryItem.stock = Stock.low;
            break;
          case Stock.low:
            pantryItem.stock = Stock.out;
            break;
          case Stock.out:
            pantryItem.stock = Stock.ok;
            break;
          default:
            // Raise an exception
            break;
        }
      }
    });
    onItemChanged(pantryItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextButton(
        onPressed: () => _handleItemChanged('stockLevel'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(isStapleIcons[pantryItem.isStaple! ? 1 : 0]),
              onPressed: () => _handleItemChanged('isStaple'),
              color: Theme.of(context).colorScheme.onPrimary,
              iconSize: 36,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(pantryItem.foodProduct!.iconData, color: Theme.of(context).colorScheme.onPrimary, size: 36),
                  const SizedBox(width: 10),
                  Text(
                    pantryItem.foodProduct!.name,
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(stockLevelIcons[pantryItem.stock]),
              onPressed: () => _handleItemChanged('stockLevel'),
              color: Theme.of(context).colorScheme.onPrimary,
              iconSize: 36,
            ),
          ],
        ),
      ),
    );
  }
}
