import 'package:flutter/material.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/widgets/fragments/pantry_item_general_fragment.dart';
import 'package:edgar/widgets/fragments/pantry_item_remove_fragment.dart';
import 'package:edgar/widgets/fragments/pantry_item_update_fragment.dart';

class PantryItemCard extends StatefulWidget {
  const PantryItemCard({super.key, required this.pantryItem, required this.onItemUpdated, required this.onItemRemoved});

  final Function(PantryItem, String) onItemUpdated;
  final Function(PantryItem) onItemRemoved;
  final PantryItem pantryItem;

  @override
  PantryItemCardState createState() => PantryItemCardState();
}

class PantryItemCardState extends State<PantryItemCard> {
  final PageController _controller = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SizedBox(
        height: 75, // Adjust the height according to your needs
        child: PageView(
          controller: _controller,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            PantryItemUpdateFragment(pantryItem: widget.pantryItem, onItemUpdated: widget.onItemUpdated),
            PantryItemGeneralFragment(pantryItem: widget.pantryItem),
            PantryItemRemoveFragment(
              pantryItem: widget.pantryItem,
              onLongPress: widget.onItemRemoved,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
