import 'package:flutter/material.dart';

import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_list.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({
    super.key,
  });

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem(BuildContext context) async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No groceries found. Start adding some!',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );

    if (_groceryItems.isNotEmpty) {
      mainContent = GroceryList(
        groceryItems: _groceryItems,
      );
    }

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
      body: mainContent,
    );
  }
}
