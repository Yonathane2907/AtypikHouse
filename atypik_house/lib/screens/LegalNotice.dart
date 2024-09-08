import 'package:flutter/material.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier

class LegalNoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mentions Légales',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '1. Présentation du site',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Le site [Nom du Site] est édité par [Nom de l\'Entreprise], dont le siège social est situé à [Adresse Complète]. Le directeur de la publication est [Nom du Directeur].',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '2. Hébergement',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Le site est hébergé par [Nom de l\'Hébergeur], situé à [Adresse de l\'Hébergeur].',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '3. Propriété intellectuelle',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Tous les éléments présents sur le site [Nom du Site], tels que les textes, images, graphismes, logos, sont protégés par le droit d\'auteur et sont la propriété exclusive de [Nom de l\'Entreprise].',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '4. Responsabilité',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'L\'éditeur du site ne saurait être tenu responsable des dommages directs ou indirects pouvant survenir lors de l\'utilisation du site. Le site peut contenir des liens vers des sites tiers sur lesquels l\'éditeur n\'exerce aucun contrôle.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '5. Données personnelles',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Les informations collectées sur le site [Nom du Site] sont destinées à [Nom de l\'Entreprise] pour les besoins de la gestion de votre compte. Conformément à la loi "Informatique et Libertés", vous disposez d\'un droit d\'accès, de rectification, de suppression et d\'opposition aux données personnelles vous concernant.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '6. Contact',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Pour toute question relative aux mentions légales, veuillez contacter [Nom de l\'Entreprise] à l\'adresse suivante : [Adresse Email de Contact].',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          Footer(), // Ajout du Footer en bas de l'écran
        ],
      ),
    );
  }
}
