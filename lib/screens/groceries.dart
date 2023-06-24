import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/grocery_list.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Groceries',
        ),
      ),
      body: GroceryList(
        groceryItems: groceryItems,
      ),
    );
  }
}
