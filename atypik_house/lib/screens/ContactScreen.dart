import 'package:flutter/material.dart';
import '../widgets/commons/appbar_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier
import '../widgets/contact_widget.dart'; // Assurez-vous d'importer le bon fichier

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ContactForm(), // Votre widget de formulaire de contact
            ),
          ),
          Footer(), // Le footer sera collé en bas
        ],
      ),
    );
  }
}
