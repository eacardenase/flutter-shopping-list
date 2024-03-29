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
          background: Container(
            padding: const EdgeInsets.only(left: 10),
            color: Colors.green.shade300,
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.check),
          ),
          secondaryBackground: Container(
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red.shade300,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete),
          ),
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
