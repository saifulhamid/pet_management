class Adoption {
  final int id;
  final String name;
  final int age;
  final String gender;
  final int numPets;

  Adoption({required this.id, required this.name, required this.age, required this.gender, required this.numPets});

  factory Adoption.fromMap(Map<String, dynamic> json) {
    return Adoption(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      numPets: json['numPets'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'gender': gender, 'numPets': numPets};
  }
}
