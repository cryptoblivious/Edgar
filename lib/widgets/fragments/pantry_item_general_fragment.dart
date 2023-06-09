import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edgar/models/pantry_item.dart';
import 'package:edgar/models/stock.dart';
import 'package:edgar/services/utils/string_utils.dart';
import 'package:edgar/widgets/dialogs/food_product_description_dialog.dart';
import 'package:edgar/widgets/snackbars/generic_snackbar.dart';

class PantryItemGeneralFragment extends StatefulWidget {
  const PantryItemGeneralFragment({super.key, required this.pantryItem});

  final PantryItem pantryItem;

  @override
  State<PantryItemGeneralFragment> createState() => _PantryItemGeneralFragmentState();
}

class _PantryItemGeneralFragmentState extends State<PantryItemGeneralFragment> {
  PantryItem get pantryItem => widget.pantryItem;

  Map<Stock, Color> stockLevelColors = {Stock.ok: Colors.green[900]!, Stock.low: Colors.yellow[900]!, Stock.out: Colors.red[900]!};

  List<IconData> isStapleIcons = [
    Icons.question_mark,
    FontAwesomeIcons.arrowsRotate,
  ];

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => {
        HapticFeedback.selectionClick(),
        showGenericSnackbar(context, message: 'Long press to show product description.'),
      },
      onLongPress: () {
        HapticFeedback.selectionClick();
        showfoodProductDescriptionDialog(context, pantryItem.foodProduct!);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          color: stockLevelColors[pantryItem.stock],
        ),
        padding: const EdgeInsets.only(left: 15),
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
            Container(
                decoration: BoxDecoration(
                  color: pantryItem.isStaple! ? Colors.blue : Colors.deepOrange,
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1.0,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                width: 50,
                height: double.maxFinite,
                child: Icon(
                  pantryItem.isStaple! ? isStapleIcons[1] : isStapleIcons[0],
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
