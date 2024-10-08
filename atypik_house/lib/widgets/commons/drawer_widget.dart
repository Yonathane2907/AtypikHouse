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
  String? userRole; // Ajout du rôle de l'utilisateur

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final role = prefs.getString('user_role'); // Supposons que le rôle soit stocké dans SharedPreferences
    setState(() {
      isLoggedIn = token != null;
      userRole = role;
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
            },
          ),
          if (userRole == 'Locataire')
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Mes réservations'),
              onTap: () {
                GoRouter.of(context).go('/mes-reservations');
              },
            ),
          if (userRole == 'admin') // Afficher pour les admins
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Administration'),
              onTap: () {
                GoRouter.of(context).go('/admin');
              },
            ),
          if (userRole == 'Propriétaire') // Afficher pour les propriétaires
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Ajouter un logement'),
              onTap: () {
                GoRouter.of(context).go('/images');
              },
            ),
          if (userRole == 'Propriétaire')
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mes logements'),
            onTap: () {
              GoRouter.of(context).go('/mes-logements');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact'),
            onTap: () {
              GoRouter.of(context).go('/contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text('Louer votre bien'),
            onTap: () {
              GoRouter.of(context).go('/commercial');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('A propos'),
            onTap: () {
              GoRouter.of(context).go('/about');
            },
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () async {
                // Supprimer les informations de stockage
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('jwt_token');
                await prefs.remove('user_role');
                setState(() {
                  isLoggedIn = false;
                  userRole = null;
                });
                _showSnackBar('Déconnecté avec succès.');
                GoRouter.of(context).go('/');
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Connexion'),
              onTap: () {
                GoRouter.of(context).go('/login');
              },
            ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Inscription'),
              onTap: () {
                GoRouter.of(context).go('/inscription');
              },
            ),
        ],
      ),
    );
  }
}