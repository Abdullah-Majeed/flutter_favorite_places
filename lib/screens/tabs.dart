import 'package:favorite_places/screens/add_places.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Place> placesList = [];

  void _addNewPlace(BuildContext context) async {
    final newPlaceData = await Navigator.of(context)
        .push<Place>(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
    if (newPlaceData == null) {
      return;
    }
    setState(() {
      placesList.add(newPlaceData);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No places found, try adding some!'),
    );

    if (placesList.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: placesList.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(placesList[index].title),
            );
          }));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _addNewPlace(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: mainContent,
    );
  }
}
