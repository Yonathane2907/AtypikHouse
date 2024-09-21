import 'dart:convert';
import 'package:http/http.dart' as http;

class LogementsService {
  Future<List<String>> fetchLogements() async {
    final response = await http.get(Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/getLogements'));

    if (response.statusCode == 200) {
      List<dynamic> logementsJson = json.decode(response.body);
      print(logementsJson);
      var test= logementsJson.map((titre) => titre.toString()).toList();
      print(test);
      return test;
    } else {
      throw Exception('Failed to load logements');
    }
  }
}