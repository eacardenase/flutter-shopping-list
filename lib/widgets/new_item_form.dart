import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItemForm extends StatelessWidget {
  const NewItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var enteredName = '';
    var enteredQuantity = 1;
    var selectedCategory = categories[Categories.vegetables];

    void saveItem() {
      final isValid = formKey.currentState!.validate();

      if (isValid) {
        formKey.currentState!.save();

        var uri = Uri.https('shopping-list-9f8d7-default-rtdb.firebaseio.com',
            'shopping-list.json');

        http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': enteredName,
            'quantity': enteredQuantity,
            'category': selectedCategory!.title
          }),
        );

        // Navigator.of(context).pop();
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
              enteredName = value!.trim();
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
                  initialValue: enteredQuantity.toString(),
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
                    enteredQuantity = int.parse(value!);
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButtonFormField(
                  value: selectedCategory,
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
                    selectedCategory = value;
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
                onPressed: resetItem,
                child: const Text('Reset'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: saveItem,
                child: const Text('Add Item'),
              )
            ],
          )
        ],
      ),
    );
  }
}
