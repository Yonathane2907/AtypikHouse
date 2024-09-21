import 'package:atypik_house/widgets/commons/appbar_widget.dart';
import 'package:atypik_house/widgets/commons/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommercialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image avec texte superposé
            Stack(
              children: [
                // Image de fond
                Image.asset(
                  'assets/img5.jpeg', // Remplace par ton image dans les assets
                  width: double.infinity,
                  height: 400, // Ajuste la hauteur si nécessaire
                  fit: BoxFit.cover,
                ),
                // Texte superposé
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "REJOIGNEZ UNE NOUVELLE EXPÉRIENCE !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texte en noir
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Louez votre bien insolite en tout sérénité et augmentez vos revenus de location ! ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          GoRouter.of(context).go('/inscription');
                        },
                        child: const Text('Rejoignez nous !'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Section "Statistiques"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 20.0, // Espace horizontal entre les éléments
                runSpacing: 20.0, // Espace vertical entre les éléments
                alignment: WrapAlignment.center, // Centrer les éléments
                children: [
                  StatCard(
                    stat: "+1000",
                    description: "lieux uniques dans toute la France",
                  ),
                  StatCard(
                    stat: "+2000",
                    description:
                    "expériences inédites disponibles à la réservation",
                  ),
                  StatCard(
                    stat: "+50",
                    description: "millions de clients satisfaits",
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String stat;
  final String description;

  const StatCard({
    required this.stat,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
