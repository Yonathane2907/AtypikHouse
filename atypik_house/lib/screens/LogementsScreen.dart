import 'package:flutter/material.dart';
import '../models/logement.dart';
import '../services/api/logement_service.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Import du widget Footer

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

class LogementDetailScreen extends StatelessWidget {
  final Logement logement;

  const LogementDetailScreen({Key? key, required this.logement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(logement.titre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://api.dsp-dev4-gv-kt-yb.fr/${logement.image_path}',
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            Text(
              logement.titre,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              logement.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${logement.prix}€ / nuit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
