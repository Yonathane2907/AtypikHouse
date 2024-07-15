import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).location;
    final isHome = currentPath == '/';

    return AppBar(
      title: const Text(
        'AtypikHouse',
        style: TextStyle(
          color: Color.fromRGBO(255, 0, 255, 1),
          fontSize: 20,
          fontFamily: 'RedditMono',
        ),
      ),
      leading: isHome
          ? null
          : IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
         context.pop();
        },
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            context.push('/');
          },
          child: const Text('Accueil'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            context.push('/login');
          },
          child: const Text('Connexion'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            context.push('/inscription');
          },
          child: const Text('Inscription'),
        )
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
