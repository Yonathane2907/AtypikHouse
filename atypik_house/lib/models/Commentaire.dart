class Commentaire {
  final String auteur;
  final String contenu;
  final DateTime date;

  Commentaire({
    required this.auteur,
    required this.contenu,
    required this.date,
  });

  // Méthode pour convertir un JSON en un objet Commentaire
  factory Commentaire.fromJson(Map<String, dynamic> json) {
    return Commentaire(
      auteur: json['auteur'],
      contenu: json['contenu'],
      date: DateTime.parse(json['date_creation']), // S'assurer que la date est bien formatée
    );
  }

  // Méthode pour convertir un objet Commentaire en JSON
  Map<String, dynamic> toJson() {
    return {
      'auteur': auteur,
      'contenu': contenu,
      'date': date.toIso8601String(),
    };
  }
}
