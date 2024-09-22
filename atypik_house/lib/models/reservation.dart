class Reservation {
  final int idReservation;
  final int idLogement;
  final int idUser;
  final String dateDebut;
  final String dateFin;
  final String status;

  Reservation({
    required this.idReservation,
    required this.idLogement,
    required this.idUser,
    required this.dateDebut,
    required this.dateFin,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      idReservation: json['id_reservation'],
      idLogement: json['id_logement'],
      idUser: json['id_user'],
      dateDebut: json['date_debut'],
      dateFin: json['date_fin'],
      status: json['status'],
    );
  }
}
