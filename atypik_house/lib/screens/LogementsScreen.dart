import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as datetime_picker_plus;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logement.dart';
import '../services/api/logement_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Commentaire.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart';

class LogementsScreen extends StatefulWidget {
  const LogementsScreen({Key? key}) : super(key: key);

  @override
  _LogementsScreenState createState() => _LogementsScreenState();
}

class _LogementsScreenState extends State<LogementsScreen> {
  List<Logement> logements = [];
  List<Logement> filteredLogements = [];
  String filterName = '';
  String filterPrice = '';

  @override
  void initState() {
    super.initState();
    _fetchLogements();
  }

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
          Padding(
            padding: const EdgeInsets.all(16.0), // Ajoutez ici l'espace
            child: const Text(
              'Logements disponibles',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
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
  String? prenom;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool isLoggedIn = false;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _fetchCommentaires();
    _getUserInfo();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final role = prefs.getString('user_role'); // Supposons que le rôle soit stocké dans SharedPreferences
    setState(() {
      isLoggedIn = token != null;
      userRole = role;
    });
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  void _getUserInfo() async {
    String? token = await getToken();
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      setState(() {
        prenom = decodedToken['user']['prenom'];
      });
    }
  }

  Future<void> _fetchCommentaires() async {
    final response = await http.get(
      Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/logements/${widget.logement.id_logement}/commentaires'),
    );
    if (response.statusCode == 200) {
      List<dynamic> commentairesJson = json.decode(response.body);
      setState(() {
        commentaires = commentairesJson.map((commentJson) => Commentaire.fromJson(commentJson)).toList();
      });
    } else {
      // Gérer l'erreur
    }
  }

  Future<void> _addCommentaire(String contenu) async {
    final response = await http.post(
      Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/logements/${widget.logement.id_logement}/commentaires'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'auteur': prenom ?? 'Anonyme', 'contenu': contenu}),
    );
    if (response.statusCode == 201) {
      setState(() {
        commentaires.add(Commentaire(auteur: prenom ?? 'Anonyme', contenu: contenu, date: DateTime.now()));
      });
      _commentController.clear();
    } else {
      // Gérer l'erreur
    }
  }

  Future<void> _makeReservation(DateTime startDate, DateTime endDate) async {
    String? token = await getToken();
    final response = await http.post(
      Uri.parse('https://api.dsp-dev4-gv-kt-yb.fr/api/reservation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'id_logement': widget.logement.id_logement,
        'id_user': 15, // Récupère l'ID utilisateur
        'date_debut': startDate.toIso8601String(),
        'date_fin': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      // Réservation réussie
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Réservation réussie'),
          content: const Text('Votre réservation a été confirmée.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Gérer l'erreur
    }
  }

  void _showReservationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Réserver ${widget.logement.titre}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sélectionnez les dates de réservation :'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  datetime_picker_plus.DatePicker.showDatePicker(context,
                      theme: datetime_picker_plus.DatePickerTheme(
                        backgroundColor: Colors.white,
                        headerColor: Colors.blue,
                        cancelStyle: const TextStyle(color: Colors.white),
                        doneStyle: const TextStyle(color: Colors.white),
                      ),
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          selectedStartDate = date;
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.fr);
                },
                child: Text(selectedStartDate == null ? 'Choisir la date de début' : 'Date de début : ${selectedStartDate!.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  datetime_picker_plus.DatePicker.showDatePicker(context,
                      theme: datetime_picker_plus.DatePickerTheme(
                        backgroundColor: Colors.white,
                        headerColor: Colors.blue,
                        cancelStyle: const TextStyle(color: Colors.white),
                        doneStyle: const TextStyle(color: Colors.white),
                      ),
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          selectedEndDate = date;
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.fr);
                },
                child: Text(selectedEndDate == null ? 'Choisir la date de fin' : 'Date de fin : ${selectedEndDate!.toLocal()}'.split(' ')[0]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedStartDate != null && selectedEndDate != null) {
                  _makeReservation(selectedStartDate!, selectedEndDate!);
                  Navigator.of(context).pop(); // Fermer le dialog
                } else {
                }
              },
              child: const Text('Réserver'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
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
              height: 400, // Hauteur augmentée
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
            if(isLoggedIn)
            Align(
              alignment: Alignment.centerRight, // Aligner le bouton à droite
              child: ElevatedButton(
                onPressed: () {
                  _showReservationDialog(context);
                },
                child: const Text('Réserver'),
              ),
            ),
            const SizedBox(height: 16),
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