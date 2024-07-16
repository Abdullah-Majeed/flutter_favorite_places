import 'dart:io';

import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreenNew extends ConsumerStatefulWidget {
  const AddPlacesScreenNew({super.key});

  @override
  ConsumerState<AddPlacesScreenNew> createState() => _AddPlacesScreenNewState();
}

class _AddPlacesScreenNewState extends ConsumerState<AddPlacesScreenNew> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  void savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: _titleController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground)),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const LocationInput(),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    savePlace();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'))
            ],
          ),
        ),
      ),
    );
  }
}
