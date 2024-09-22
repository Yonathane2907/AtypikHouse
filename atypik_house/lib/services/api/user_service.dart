import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ChangeNotifier {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://localhost:3000';

  Future<String> inscription(String nom, String prenom, String adresse, String email, String password, String role) async {
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
        'role': role
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String token = data['token'];
      final String role = data['role'];

      // Stocker le token et le rôle dans SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      await prefs.setString('user_role', role);

      return 'Inscription réussie.';
    } else {
      final errorResponse = jsonDecode(response.body);
      return errorResponse['error'] ?? 'Erreur inconnue';
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
      final String role = data['user']['role'];
      final int userId = data['user']['id'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      await prefs.setString('user_role', role);
      await prefs.setInt('user_id', userId);

      return true;
    } else {
      try {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'Erreur inconnue');
      } catch (e) {
        throw Exception('Erreur lors de l\'appel à l\'API');
      }
    }
  }


  Future<void> logout() async {
    // Supprimer les informations de stockage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_role');
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }
}
