import 'pantry_item.dart';
import 'stock_level.dart';

class Pantry {
  List<PantryItem> items = [];

  void handleItemChanged(PantryItem item) {
    int index = items.indexOf(item);
    if (index != -1) {
      if (!item.isStaple && item.stockLevel == StockLevel.outOfStock) {
        print('Removing item from pantry');
        items.remove(item);
      }
    }
  }
}
