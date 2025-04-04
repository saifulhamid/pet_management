import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet_model.dart';

class PetService {
  Future<List<Pet>> fetchPets() async {
    final response = await http.get(
      Uri.parse('https://jatinderji.github.io/users_pets_api/users_pets.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the list of pets
      if (responseData.containsKey('data')) {
        final List<dynamic> users = responseData['data'];

        // Extract pets from each user
        List<Pet> pets = [];
        for (var user in users) {
          if (user.containsKey('pets')) {
            final List<dynamic> userPets = user['pets'];
            pets.addAll(userPets.map((json) => Pet.fromJson(json)).toList());
          }
        }

        return pets;
      } else {
        throw Exception('Invalid API response: "users" key not found');
      }
    } else {
      throw Exception('Failed to load pets');
    }
  }
}
