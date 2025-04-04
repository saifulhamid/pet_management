class Pet {
  final String name;
  final bool isFriendly;

  Pet({required this.name, required this.isFriendly});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'] ?? '',
      isFriendly: json['isFriendly'] ?? false,
    );
  }
}
