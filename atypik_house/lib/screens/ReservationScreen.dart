import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/reservation.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';

class ReservationsScreen extends StatefulWidget {
  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List<Reservation> reservations = [];

  @override
  void initState() {
    super.initState();
    fetchUserIdAndReservations();
  }

  Future<void> fetchUserIdAndReservations() async {
    final prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');

    if (currentUserId != null) {
      fetchReservations(currentUserId);
    } else {
      print('Aucun ID d\'utilisateur trouvé');
    }
  }

  Future<void> fetchReservations(int userId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.dsp-dev4-gv-kt-yb.fr/api/reservations/$userId'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          reservations =
              jsonResponse.map((json) => Reservation.fromJson(json)).toList();
        });
      } else {
        throw Exception('Erreur de chargement des réservations');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: DrawerWidget(),
      body: reservations.isEmpty
          ? const Center(
          child: Text('Aucune réservation trouvée.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Logement ID: ${reservation.idLogement}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date de début: ${reservation.dateDebut}'),
                  Text('Date de fin: ${reservation.dateFin}'),
                  Text('Status: ${reservation.status}'),
                ],
              ),
              onTap: () {}
            ),
          );
        },
      ),
    );
  }

}
