class Logement {
  final int id_logement;
  final int proprietaire_id;
  final String image_path;
  final String titre;
  final String description;
  final String adresse;
  final int capacite;
  final int nombre_couchage;
  final int prix;
  final DateTime date_creation;

  Logement({
    required this.id_logement,
    required this.proprietaire_id,
    required this.image_path,
    required this.titre,
    required this.description,
    required this.adresse,
    required this.capacite,
    required this.nombre_couchage,
    required this.prix,
    required this.date_creation,
  });

  factory Logement.fromJson(Map<String, dynamic> json) {
    return Logement(
      id_logement: json['id_logement'],
      proprietaire_id: json['proprietaire_id'],
      image_path: json['image_path'],
      titre: json['titre'],
      description: json['description'],
      adresse: json['adresse'],
      capacite: json['capacite'],
      nombre_couchage: json['nombre_couchage'],
      prix: json['prix'],
      date_creation: DateTime.parse(json['date_creation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_logement': id_logement,
      'proprietaire_id': proprietaire_id,
      'image_path': image_path,
      'titre': titre,
      'description': description,
      'adresse': adresse,
      'capacite': capacite,
      'nombre_couchage': nombre_couchage,
      'prix': prix,
      'date_creation': date_creation.toIso8601String(),
    };
  }
}
