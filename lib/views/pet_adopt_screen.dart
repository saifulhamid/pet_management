import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/adoption_model.dart';
import '../provider/adoption_provider.dart';
import '../provider/pet_provider.dart';

class PetAdoptScreen extends StatefulWidget {
  const PetAdoptScreen({super.key});

  @override
  State<PetAdoptScreen> createState() => _PetAdoptScreenState();
}

class _PetAdoptScreenState extends State<PetAdoptScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedPet;
  String? name;
  int? age;
  String? gender;
  int? numPets;

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final adoptionProvider = Provider.of<AdoptionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Adopt a Pet")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: const Text("Select a pet"),
                value: selectedPet,
                items: petProvider.friendlyPets.map((pet) {
                  return DropdownMenuItem(
                    value: pet.name,
                    child: Text(pet.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedPet = value),
                validator: (value) => value == null ? 'Please select a pet' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Your Name"),
                onSaved: (value) => name = value,
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                onSaved: (value) => age = int.tryParse(value!),
                validator: (value) => value!.isEmpty ? 'Enter age' : null,
              ),
              DropdownButtonFormField<String>(
                hint: const Text("Select Gender"),
                value: gender,
                items: ['Male', 'Female'].map((g) {
                  return DropdownMenuItem(value: g, child: Text(g));
                }).toList(),
                onChanged: (value) => setState(() => gender = value),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Number of Pets"),
                keyboardType: TextInputType.number,
                onSaved: (value) => numPets = int.tryParse(value!),
                validator: (value) => value!.isEmpty ? 'Enter number of pets' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await adoptionProvider.addAdoption(Adoption(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: name!,
                      age: age!,
                      gender: gender!,
                      numPets: numPets!,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text("Confirm Adoption"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
