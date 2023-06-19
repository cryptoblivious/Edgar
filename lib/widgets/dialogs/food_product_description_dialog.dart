import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/food_product.dart';
import 'package:edgar/services/utils/string_utils.dart';

void showfoodProductDescriptionDialog(BuildContext context, FoodProduct foodProduct) {
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          capitalize(foodProduct.name),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondaryContainer),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
            child: Text(
          foodProduct.description,
          style: const TextStyle(fontSize: 28),
          textAlign: TextAlign.justify,
        )),
        actions: [
          Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onSecondary),
              ),
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
