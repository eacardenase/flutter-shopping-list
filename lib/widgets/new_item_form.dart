import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItemForm extends StatefulWidget {
  const NewItemForm({super.key});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables];
  var _isSendingRequest = false;

  @override
  Widget build(BuildContext context) {
    void saveItem() async {
      final isValid = formKey.currentState!.validate();

      if (isValid) {
        formKey.currentState!.save();

        setState(() {
          _isSendingRequest = true;
        });

        var uri = Uri.https('shopping-list-9f8d7-default-rtdb.firebaseio.com',
            'shopping-list.json');

        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory!.title
          }),
        );

        final Map<String, dynamic> responseData = json.decode(response.body);

        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pop(
          GroceryItem(
              id: responseData['name'],
              name: _enteredName,
              quantity: _enteredQuantity,
              category: _selectedCategory!),
        );
      }
    }

    void resetItem() {
      formKey.currentState!.reset();
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                'Name',
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length < 2 ||
                  value.trim().length > 50) {
                return 'Must be between 1 and 50 characters.';
              }

              return null;
            },
            onSaved: (value) {
              _enteredName = value!.trim();
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text(
                      'Quantity',
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _enteredQuantity.toString(),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Must be a valid positive number.';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _enteredQuantity = int.parse(value!);
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButtonFormField(
                  value: _selectedCategory,
                  items: [
                    for (final category in categories.values)
                      DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: category.color,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              category.title,
                            ),
                          ],
                        ),
                      )
                  ],
                  onChanged: (value) {
                    _selectedCategory = value;
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isSendingRequest ? null : resetItem,
                child: const Text('Reset'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: _isSendingRequest ? null : saveItem,
                child: _isSendingRequest
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Add Item'),
              )
            ],
          )
        ],
      ),
    );
  }
}
