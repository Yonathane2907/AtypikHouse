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
                      'Nom de l\'Application',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Cette application est conçue pour fournir des fonctionnalités X, Y, et Z. Elle vise à aider les utilisateurs à accomplir A, B, et C de manière efficace et intuitive.',
                      style: Theme.of(context).textTheme.bodyLarge, // Utilisation de bodyLarge ou bodyText1
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Développeur',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Développé par [Votre Nom]. Vous pouvez nous contacter à l\'adresse suivante : [votre.email@example.com]. Nous apprécions vos retours et suggestions pour améliorer l\'application.',
                      style: Theme.of(context).textTheme.bodyLarge, // Utilisation de bodyLarge ou bodyText1
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Version',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Version 1.0.0',
                      style: Theme.of(context).textTheme.bodyLarge, // Utilisation de bodyLarge ou bodyText1
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Remerciements',
                      style: Theme.of(context).textTheme.titleMedium, // Utilisation de titleMedium ou headline6
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Merci à tous ceux qui ont contribué au développement de cette application, y compris les développeurs de bibliothèques open-source et la communauté Flutter.',
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
