import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnauthorizedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Non Autorisé'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vous n\'avez pas les droits nécessaires pour accéder à cette page.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Espacement entre le texte et le bouton
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/'); // Naviguer vers la page d'accueil
              },
              child: Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
