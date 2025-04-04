import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/adoption_provider.dart';

class AdoptionDetailsScreen extends StatefulWidget {
  const AdoptionDetailsScreen({super.key});

  @override
  State<AdoptionDetailsScreen> createState() => _AdoptionDetailsScreenState();
}

class _AdoptionDetailsScreenState extends State<AdoptionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdoptionProvider>(context, listen: false).loadAdoptions();
  }

  @override
  Widget build(BuildContext context) {
    final adoptionProvider = Provider.of<AdoptionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Adoption Details")),
      body: adoptionProvider.adoptions.isEmpty
          ? const Center(child: Text("No adoptions yet!"))
          : ListView.builder(
        itemCount: adoptionProvider.adoptions.length,
        itemBuilder: (context, index) {
          final adoption = adoptionProvider.adoptions[index];
          return Card(
            child: ListTile(
              title: Text("${adoption.name} adopted ${adoption.numPets} pet(s)"),
              subtitle: Text("Age: ${adoption.age} | Gender: ${adoption.gender}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  adoptionProvider.removeAdoption(adoption.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
