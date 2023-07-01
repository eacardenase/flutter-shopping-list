import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({
    super.key,
    required this.groceryItems,
    required this.onRemoveItem,
  });

  final List<GroceryItem> groceryItems;
  final void Function(int index, GroceryItem item) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        final groceryItem = groceryItems[index];

        return Dismissible(
          key: ValueKey(groceryItem.id),
          onDismissed: (direction) {
            onRemoveItem(index, groceryItem);
          },
          child: ListTile(
            title: Text(
              groceryItem.name,
            ),
            leading: Container(
              width: 24,
              height: 24,
              color: groceryItem.category.color,
            ),
            trailing: Text(
              groceryItem.quantity.toString(),
            ),
          ),
        );
      },
    );
  }
}
