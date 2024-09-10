import 'package:flutter/material.dart';
import '../models/logement.dart';
import '../services/api/logement_service.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Import du widget Footer

class LogementsScreen extends StatelessWidget {
  const LogementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Logement>>(
              future: LogementService().fetchLogements(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('Aucun logement disponible'));
                  } else {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount;
                        double childAspectRatio;
                        double imageHeight;

                        // Déterminer le nombre de colonnes, le ratio aspect et la hauteur de l'image
                        if (constraints.maxWidth > 1200) {
                          crossAxisCount = 4; // 4 colonnes pour les grands écrans (PC)
                          childAspectRatio = 0.6; // Ratio pour les cartes plus petites
                          imageHeight = 250; // Hauteur de l'image pour les grands écrans
                        } else if (constraints.maxWidth > 800) {
                          crossAxisCount = 3; // 3 colonnes pour les écrans moyens
                          childAspectRatio = 0.7; // Ratio pour les cartes moyennes
                          imageHeight = 200; // Hauteur de l'image pour les écrans moyens
                        } else {
                          crossAxisCount = 2; // 2 colonnes pour les petits écrans (mobiles)
                          childAspectRatio = 0.8; // Ratio pour les cartes plus grandes
                          imageHeight = 180; // Hauteur de l'image pour les petits écrans
                        }

                        return SingleChildScrollView(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            shrinkWrap: true, // Important pour éviter le débordement
                            physics: NeverScrollableScrollPhysics(), // Désactiver le défilement du GridView
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Logement logement = snapshot.data![index];
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
                                        aspectRatio: 16 / 9, // Hauteur de l'image relative à sa largeur
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
                    );
                  }
                } else {
                  return const Center(child: Text('Aucun logement disponible'));
                }
              },
            ),
          ),
          Footer(), // Le footer sera collé en bas
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
              height: 300, // Hauteur fixe pour la vue détail
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
