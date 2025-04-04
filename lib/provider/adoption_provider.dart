import 'package:flutter/material.dart';
import '../core/database.dart';
import '../models/adoption_model.dart';

class AdoptionProvider with ChangeNotifier {
  List<Adoption> _adoptions = [];

  List<Adoption> get adoptions => _adoptions;

  Future<void> loadAdoptions() async {
    _adoptions = await DatabaseHelper.instance.getAdoptions();
    notifyListeners();
  }

  Future<void> addAdoption(Adoption adoption) async {
    await DatabaseHelper.instance.insertAdoption(adoption);
    await loadAdoptions();
  }

  Future<void> removeAdoption(int id) async {
    await DatabaseHelper.instance.deleteAdoption(id);
    await loadAdoptions();
  }
}
