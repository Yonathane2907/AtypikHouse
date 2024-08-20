import 'package:atypik_house/widgets/commons/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/contact_widget.dart'; // Assurez-vous d'importer le bon fichier

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: ContactForm(),
    );
  }
}
