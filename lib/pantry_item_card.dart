import 'package:flutter/material.dart';

class PantryItemCard extends StatefulWidget {
  const PantryItemCard(
      {super.key, required this.productName, required this.productType});

  final String productName;
  final IconData productType;

  @override
  State<PantryItemCard> createState() => _PantryItemCardState();
}

class _PantryItemCardState extends State<PantryItemCard> {
  List<IconData> stockLevelIcons = [
    Icons.hourglass_full,
    Icons.hourglass_bottom,
    Icons.hourglass_empty,
  ];

  List<IconData> isStapleIcons = [
    Icons.favorite_border,
    Icons.favorite,
  ];

  void _rotateIconList(List<IconData> iconList) {
    setState(() {
      //make it so the second icon is the first icon, and the first icon is the last icon
      iconList.add(iconList.removeAt(0));
    });
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
        onPressed: () => _rotateIconList(stockLevelIcons),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(isStapleIcons[0]),
              onPressed: () => _rotateIconList(isStapleIcons),
              color: Theme.of(context).colorScheme.onPrimary,
              iconSize: 36,
            ),
            Row(
              children: [
                Icon(widget.productType,
                    color: Theme.of(context).colorScheme.onPrimary, size: 36),
                const SizedBox(width: 10),
                Text(
                  widget.productName,
                  style: TextStyle(
                    fontSize: 36,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(stockLevelIcons[0]),
              onPressed: () => _rotateIconList(stockLevelIcons),
              color: Theme.of(context).colorScheme.onPrimary,
              iconSize: 36,
            ),
          ],
        ),
      ),
    );
  }
}
