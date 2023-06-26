import 'package:edgar/models/food_product.dart';
import 'package:edgar/services/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:edgar/widgets/fragments/grocery_item_general_fragment.dart';
import 'package:edgar/widgets/fragments/grocery_item_remove_fragment.dart';
import 'package:edgar/widgets/fragments/grocery_item_update_fragment.dart';

class GroceryItemCard extends StatefulWidget {
  const GroceryItemCard({super.key, required this.foodProduct, required this.onItemUpdated});

  final Function(FoodProduct, String) onItemUpdated;
  final FoodProduct foodProduct;

  @override
  GroceryItemCardState createState() => GroceryItemCardState();
}

class GroceryItemCardState extends State<GroceryItemCard> {
  final PageController _controller = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SizedBox(
        height: cardHeight, // Adjust the height according to your needs
        child: PageView(
          controller: _controller,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            GroceryItemUpdateFragment(foodProduct: widget.foodProduct, onItemUpdated: widget.onItemUpdated),
            GroceryItemGeneralFragment(foodProduct: widget.foodProduct),
            GroceryItemRemoveFragment(
              foodProduct: widget.foodProduct,
              onLongPress: widget.onItemUpdated,
            )
          ],
        ),
      ),
    );
  }
}
