import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).location;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 109, 151, 184),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Découvrir'),
            onTap: () {
              GoRouter.of(context).go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text('Nos habitats'),
            onTap: () {
              GoRouter.of(context).go('/logements');
              // Ajoutez ici la navigation vers la page "Nos habitats"
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact'),
            onTap: () {
              GoRouter.of(context).go('/contact');
              // Ajoutez ici la navigation vers la page "Contact"
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Espace propriétaire'),
            onTap: () {
              Navigator.pop(context);
              // Ajoutez ici la navigation vers la page "Espace propriétaire"
            },
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('jwt_token');
                setState(() {
                  isLoggedIn = false;
                });
                _showSnackBar('Déconnecté avec succès.');
                GoRouter.of(context).go('/login');
                Navigator.pop(context);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Connexion'),
              onTap: () {
                GoRouter.of(context).go('/login');
                Navigator.pop(context);
              },
            ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Inscription'),
              onTap: () {
                GoRouter.of(context).go('/inscription');
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
