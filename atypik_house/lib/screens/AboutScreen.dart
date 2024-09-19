import 'package:flutter/material.dart';

import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'À Propos de l\'Application',
                      style: Theme.of(context).textTheme.titleLarge, // Utilisation de titleLarge ou headline6
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Qui sommes-nous ?',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'AtypikHouse est le fruit de la passion commune de trois associées, animées par un amour profond pour les voyages, l\'habitat alternatif et un mode de vie en parfaite harmonie avec la nature. \n Ensemble, nous mettons tout en œuvre pour vous offrir une sélection exclusive de logements atypiques, pour que chaque séjour devienne une aventure inoubliable et une escapade hors du commun.',
                      style: Theme.of(context).textTheme.bodyLarge, // Utilisation de bodyLarge ou bodyText1
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Avec Atypikhouse',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Nous vous proposons une sélection variée de logements atypiques pour des séjours uniques et mémorables. Du charme d\'une cabane dans les arbres à \'élégance d\'une bulle insolite, en passant par le confort d\'une maison flottante, nos hébergements vous offrent une expérience hors du commun.\n Chaque logement a été soigneusement choisi pour son caractère unique, son emplacement en harmonie avec la nature et les souvenirs inoubliables qu\'il vous procurera. Que vous recherchiez une escapade romantique, une aventure en famille ou une expérience insolite entre amis, Atypik House vous ouvre les portes d\'un monde de possibilités.\n Nos logements sont également conçus pour respecter l\'environnement, avec une approche écoresponsable et durable. Nous croyons en un tourisme respectueux de la nature et des communautés locales, et nous nous engageons à préserver la beauté de nos destinations.\n Préparez-vous à vivre des moments inoubliables et à créer des souvenirs impérissables dans nos logements atypiques. Réservez dès maintenant votre prochaine aventure avec Atypik House !',
                      style: Theme.of(context).textTheme.bodyLarge, // Utilisation de bodyLarge ou bodyText1
                    ),
                  ],
                ),
              ),
            ),
          ),
          Footer(), // Le footer sera collé en bas
        ],
      ),
    );
  }
}
