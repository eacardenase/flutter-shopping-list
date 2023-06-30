import 'package:flutter/material.dart';

import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_list.dart';
import 'package:shopping_list/data/dummy_items.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({
    super.key,
  });

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  void _addItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItemScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Groceries',
        ),
        actions: [
          IconButton(
            onPressed: () => _addItem(context),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: GroceryList(
        groceryItems: groceryItems,
      ),
    );
  }
}
