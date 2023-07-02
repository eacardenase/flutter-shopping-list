import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
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
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  void _getItems() async {
    final uri = Uri.https('shopping-list-9f8d7-default-rtdb.firebaseio.com',
        'shopping-list.json');
    final response = await http.get(uri);
    final List<GroceryItem> loadedItems = [];
    final Map<String, dynamic> listItems = json.decode(response.body);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to load items. Please try again later.';
      });
    }

    for (var item in listItems.entries) {
      final category = categories.entries
          .firstWhere((itemCategory) =>
              itemCategory.value.title == item.value['category'])
          .value;

      final groceryItem = GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        // category: categories[item.value['category']]!,
        category: category,
      );

      loadedItems.add(groceryItem);
    }

    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

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

  void _removeItem(int index, GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 2,
        ),
        content: const Text(
          'Grocery Item deleted!',
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _groceryItems.insert(index, item);
              });
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _getItems();
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

    if (_isLoading) {
      mainContent = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      mainContent = GroceryList(
        groceryItems: _groceryItems,
        onRemoveItem: _removeItem,
      );
    }

    if (_error != null) {
      mainContent = Center(
        child: Text(
          _error!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
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
