import 'package:flutter/material.dart';
import './commons/footer.dart';
import './commons/carousel_section.dart';
import './commons/villa_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Atypik House',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
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
                Navigator.pop(context);
                // Ajoutez ici la navigation vers la page "Découvrir"
              },
            ),
            ListTile(
              leading: const Icon(Icons.house),
              title: const Text('Nos habitats'),
              onTap: () {
                Navigator.pop(context);
                // Ajoutez ici la navigation vers la page "Nos habitats"
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context);
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
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Connexion/inscription'),
              onTap: () {
                Navigator.pop(context);
                // Ajoutez ici la navigation vers la page de connexion/inscription
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSection(),
            const VillaSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
