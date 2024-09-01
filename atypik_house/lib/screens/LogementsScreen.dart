import 'package:atypik_house/widgets/commons/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/logement.dart';
import '../services/api/logement_service.dart';
import '../widgets/commons/appbar_widget.dart';

class LogementsScreen extends StatelessWidget {
  const LogementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: FutureBuilder<List<Logement>>(
        future: LogementService().fetchLogements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Logement logement = snapshot.data![index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://92.113.27.31/${logement.image_path}',  // Utilisez Image.network pour charger les images à partir d'une URL
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,  // Vous pouvez ajuster la hauteur selon vos besoins
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logement.titre,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              logement.description,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${logement.prix}€ / nuit',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Aucun logement disponible'));
          }
        },
      ),
    );
  }
}
