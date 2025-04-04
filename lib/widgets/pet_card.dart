import 'package:flutter/material.dart';
import '../models/pet_model.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pet.name),
        subtitle: Text(pet.isFriendly ? "Friendly" : "Not Friendly"),
      ),
    );
  }
}
