import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/new_item_form.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemState();
}

class _NewItemState extends State<NewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a new item',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(
          12,
        ),
        child: NewItemForm(),
      ),
    );
  }
}
