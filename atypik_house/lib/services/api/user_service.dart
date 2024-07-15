import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';

class UserService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/getUsers'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((user) => User.fromJson(user)).toList();

    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> inscription(String nom, String prenom, String adresse, String email, String password) async {
    final url = Uri.parse('$baseUrl/api/signUp');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'adresse': adresse,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Succès
      print('Inscription réussie');
    } else {
      // Gestion des erreurs
      print('Erreur lors de l\'inscription : ${response.statusCode}');
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Succès
      print('Inscription réussie');
    } else {
      // Gestion des erreurs
      print('Erreur lors de l\'inscription : ${response.statusCode}');
    }
  }
}
