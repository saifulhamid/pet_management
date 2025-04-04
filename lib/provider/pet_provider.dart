import 'package:flutter/material.dart';

import '../core/pet_service.dart';
import '../models/pet_model.dart';

class PetProvider with ChangeNotifier {
  List<Pet> _pets = [];

  List<Pet> get pets => _pets;
  List<Pet> get friendlyPets => _pets.where((pet) => pet.isFriendly).toList();

  Future<void> loadPets() async {
    _pets = await PetService().fetchPets();
    notifyListeners();
  }
}
