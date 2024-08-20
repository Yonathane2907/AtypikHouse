import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/logement.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class LogementService extends ChangeNotifier {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  Future<List<Logement>> fetchLogements() async {
    final response = await http.get(Uri.parse('$baseUrl/api/getLogements'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((logement) => Logement.fromJson(logement)).toList();
    } else {
      throw Exception('Failed to load logements');
    }
  }
}
