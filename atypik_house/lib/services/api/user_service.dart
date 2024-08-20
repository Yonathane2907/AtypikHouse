import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ChangeNotifier {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://92.113.27.31:3000';

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

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String token = data['token'];

      // Stocker le token dans SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }

}
