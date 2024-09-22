import 'dart:convert';
import 'package:atypik_house/widgets/commons/appbar_widget.dart';
import 'package:atypik_house/widgets/commons/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logement.dart';
import 'LogementsScreen.dart'; // Importer le fichier contenant LogementDetailScreen

class MyLogementsPage extends StatefulWidget {
  @override
  _MyLogementsPageState createState() => _MyLogementsPageState();
}

class _MyLogementsPageState extends State<MyLogementsPage> {
  List<dynamic> _logements = [];
  bool _isLoading = true;
  int? _proprietaireId;

  @override
  void initState() {
    super.initState();
    _fetchLogements();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _fetchLogements() async {
    final token = await getToken();
    if (token == null) {
      _showMessage(context, 'Utilisateur non authentifié.');
      return;
    }

    try {
      final decodedToken = jwtDecode(token);
      final userId = decodedToken['user']['id'];
      await _getProprietaireId(userId);

      if (_proprietaireId == null) {
        _showMessage(context, 'Propriétaire non trouvé.');
        return;
      }

      final response = await http.get(
        Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/logements/$_proprietaireId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _logements = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Échec du chargement des logements');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getProprietaireId(int userId) async {
    try {
      final response = await http.get(Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/proprietaire/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _proprietaireId = data['id_proprietaire'];
        });
      } else {
        _showMessage(context, 'Erreur lors de la récupération du proprietaire_id.');
      }
    } catch (e) {
      _showMessage(context, 'Erreur lors de la connexion au serveur : $e');
    }
  }

  Map<String, dynamic> jwtDecode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    return jsonDecode(utf8.decode(payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _logements.isEmpty
          ? Center(child: Text('Aucun logement trouvé.'))
          : ListView.builder(
        itemCount: _logements.length,
        itemBuilder: (context, index) {
          final logement = _logements[index];
          return ListTile(
            leading: Image.network(
              'https://api.dsp-dev4-gv-kt-yb.fr/${logement['image_path']}',
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
            title: Text(logement['titre']),
            subtitle: Text(logement['description']),
            trailing: Text('${logement['prix']} €'),
            onTap: () {
              // Naviguer vers la page de détail du logement
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogementDetailScreen(logement: Logement.fromJson(logement)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
