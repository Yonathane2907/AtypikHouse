import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logement.dart';
import '../services/api/logement_service.dart'; // Service pour récupérer les logements
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Import du widget Footer
import '../models/Commentaire.dart';

class LogementsScreen extends StatefulWidget {
  const LogementsScreen({Key? key}) : super(key: key);

  @override
  _LogementsScreenState createState() => _LogementsScreenState();
}

class _LogementsScreenState extends State<LogementsScreen> {
  List<Logement> logements = [];
  List<Logement> filteredLogements = [];

  // Champs de filtre
  String filterName = '';
  String filterPrice = '';

  @override
  void initState() {
    super.initState();
    _fetchLogements();
  }

  // Méthode pour récupérer les logements et les filtrer
  Future<void> _fetchLogements() async {
    try {
      List<Logement> logementsList = await LogementService().fetchLogements();
      setState(() {
        logements = logementsList;
        _applyFilters();
      });
    } catch (error) {
      // Gérer l'erreur
    }
  }

  // Méthode pour appliquer les filtres
  void _applyFilters() {
    setState(() {
      filteredLogements = logements.where((logement) {
        final matchesName = logement.titre.toLowerCase().contains(filterName.toLowerCase());
        final double? maxPrice = double.tryParse(filterPrice);
        final matchesPrice = filterPrice.isEmpty || (maxPrice != null && logement.prix <= maxPrice);
        return matchesName && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          // Ajout des filtres
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Filtre par nom
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrer par nom',
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterName = value;
                        _applyFilters();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Filtre par prix
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrer par prix maximum',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        filterPrice = value;
                        _applyFilters();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Affichage des logements
          Expanded(
            child: filteredLogements.isEmpty
                ? const Center(child: Text('Aucun logement correspondant'))
                : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double childAspectRatio;
                double imageHeight;

                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 4;
                  childAspectRatio = 0.6;
                  imageHeight = 250;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 3;
                  childAspectRatio = 0.7;
                  imageHeight = 200;
                } else {
                  crossAxisCount = 2;
                  childAspectRatio = 0.8;
                  imageHeight = 180;
                }

                return SingleChildScrollView(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: filteredLogements.length,
                    itemBuilder: (context, index) {
                      Logement logement = filteredLogements[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogementDetailScreen(logement: logement),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    'https://api.dsp-dev4-gv-kt-yb.fr/${logement.image_path}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      logement.titre,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      logement.description,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${logement.prix}€ / nuit',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class LogementDetailScreen extends StatefulWidget {
  final Logement logement;

  const LogementDetailScreen({Key? key, required this.logement}) : super(key: key);

  @override
  _LogementDetailScreenState createState() => _LogementDetailScreenState();
}

class _LogementDetailScreenState extends State<LogementDetailScreen> {
  List<Commentaire> commentaires = [];
  final TextEditingController _commentController = TextEditingController();
  String? prenom; // Pour stocker le prénom de l'utilisateur

  @override
  void initState() {
    super.initState();
    _fetchCommentaires();
    _getUserInfo(); // Récupérer le prénom de l'utilisateur
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token'); // 'token' est la clé sous laquelle tu as stocké le token
  }

  // Récupérer le prénom de l'utilisateur à partir du token JWT
  void _getUserInfo() async {
    String? token = await getToken(); // Récupérer le token JWT
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      setState(() {
        prenom = decodedToken['user']['prenom']; // Récupérer le prénom
      });
    }
  }

  // Méthode pour récupérer les commentaires depuis le backend
  Future<void> _fetchCommentaires() async {
    final response = await http.get(
      Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/logements/${widget.logement.id_logement}/commentaires'),
    );
    if (response.statusCode == 200) {
      List<dynamic> commentairesJson = json.decode(response.body);
      setState(() {
        commentaires = commentairesJson
            .map((commentJson) => Commentaire.fromJson(commentJson))
            .toList();
      });
    } else {
      // Gérer l'erreur
    }
  }

  // Méthode pour ajouter un commentaire
  Future<void> _addCommentaire(String contenu) async {
    final response = await http.post(
      Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/logements/${widget.logement.id_logement}/commentaires'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'auteur': prenom ?? 'Anonyme', 'contenu': contenu}), // Utiliser le prénom ou "Anonyme"
    );
    if (response.statusCode == 201) {
      setState(() {
        commentaires.add(
          Commentaire(auteur: prenom ?? 'Anonyme', contenu: contenu, date: DateTime.now()),
        );
      });
      _commentController.clear();
    } else {
      // Gérer l'erreur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.logement.titre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://api.dsp-dev4-gv-kt-yb.fr/${widget.logement.image_path}',
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              widget.logement.titre,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.logement.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.logement.prix}€ / nuit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            // Section des commentaires
            Expanded(
              child: ListView.builder(
                itemCount: commentaires.length,
                itemBuilder: (context, index) {
                  final commentaire = commentaires[index];
                  return ListTile(
                    title: Text(commentaire.auteur),
                    subtitle: Text(commentaire.contenu),
                    trailing: Text(
                      '${commentaire.date.day}/${commentaire.date.month}/${commentaire.date.year}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Champ pour ajouter un commentaire
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Ajouter un commentaire',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      _addCommentaire(_commentController.text);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


