// lib/models/villa_model.dart
class Villa {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;

  Villa({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Villa.fromJson(Map<String, dynamic> json) {
    return Villa(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}