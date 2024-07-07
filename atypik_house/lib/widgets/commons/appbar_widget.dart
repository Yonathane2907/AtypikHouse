import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /*
        title: texte, icône, ou image
        centerTitle: centrer le titre
        leading: regroupement de widgets à gauche de la barre de navigation
        actions: regroupement de widgets à droite de la barre de navigation…
      */
      title: const Text(
        'AtypikHouse',
        style: TextStyle(
            color: Color.fromRGBO(255, 0, 255, 1),
            fontSize: 20,
            fontFamily: 'RedditMono'
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            context.go('/login');
          },
          child: const Text('Connexion'),
        )
      ],
      centerTitle: true,
    );
  }

  // Permet de définir la hauteur de la barre de navigation
  @override
  Size get preferredSize => const Size.fromHeight(55);
}