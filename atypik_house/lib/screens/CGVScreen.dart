import 'package:flutter/material.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier

class ContratGeneralVente extends StatelessWidget {
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
    'Conformément aux dispositions des articles 6-III et 19 de la Loi n° 2004-575 du 21 juin 2004 pour la Confiance dans l’Économie Numérique (LCEN), nous portons à la connaissance des utilisateurs et visiteurs du site https://dsp-dev4-gv-kt-yb.fr/ les informations suivantes :',
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    SizedBox(height: 16.0),

    Text(
    '1. Informations légales',
    style: Theme.of(context).textTheme.titleLarge,
    ),
    SizedBox(height: 8.0),
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
