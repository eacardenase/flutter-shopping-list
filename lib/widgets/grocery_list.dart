import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({
    super.key,
    required this.groceryItems,
  });

  final List<GroceryItem> groceryItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        final groceryItem = groceryItems[index];

        return ListTile(
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
        );
      },
    );
  }
}
