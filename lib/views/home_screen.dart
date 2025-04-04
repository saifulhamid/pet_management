import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pet_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PetProvider>(context, listen: false).loadPets();
  }

  @override
  Widget build(BuildContext context) {
    final pets = Provider.of<PetProvider>(context).friendlyPets;

    return Scaffold(
      appBar: AppBar(title: const Text("Pet Management")),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pets[index].name),
            subtitle: Text(pets[index].isFriendly ? "Friendly" : "Not Friendly"),
          );
        },
      ),
    );
  }
}
