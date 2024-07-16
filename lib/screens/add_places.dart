import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        Place(title: _enteredTitle,image: File('')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 characters.";
                    }
                    return null;
                  },
                  maxLength: 50,
                  onSaved: (newValue) {
                    _enteredTitle = newValue!;
                  },
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton.icon(
                  onPressed: _saveItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
