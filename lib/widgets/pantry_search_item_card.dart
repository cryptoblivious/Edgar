import 'package:flutter/material.dart';

class PantryItemCard extends StatefulWidget {
  const PantryItemCard({super.key, required this.productName, required this.productIcon});

  final String productName;
  final IconData productIcon;

  @override
  State<PantryItemCard> createState() => _PantryItemCardState();
}

class _PantryItemCardState extends State<PantryItemCard> {
  List<IconData> icons = [
    Icons.add,
    Icons.cached,
    Icons.one_x_mobiledata,
  ];

  void _rotateIcon() {
    setState(() {
      icons.add(icons.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextButton.icon(
        onPressed: _rotateIcon,
        icon: Icon(
          widget.productIcon,
        ),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icons[0]),
          ],
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Theme.of(context).colorScheme.onSecondary.withOpacity(0.04);
              }
              if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.onSecondary.withOpacity(0.12);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
      ),
    );
  }
}
