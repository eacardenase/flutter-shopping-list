import 'package:flutter/material.dart';

import 'package:shopping_list/data/categories.dart';

class NewItemForm extends StatelessWidget {
  const NewItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
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
              return null;
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
                  initialValue: '1',
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButtonFormField(items: [
                  for (final category in categories.entries)
                    DropdownMenuItem(
                      value: category.value,
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: category.value.color,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            category.value.title,
                          ),
                        ],
                      ),
                    )
                ], onChanged: (value) {}),
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
                onPressed: () {},
                child: const Text('Reset'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Item'),
              )
            ],
          )
        ],
      ),
    );
  }
}
