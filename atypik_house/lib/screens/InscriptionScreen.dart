import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/commons/appbar_widget.dart';
import '../services/api/user_service.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/login/inscription_widget.dart';
import '../widgets/commons/footer.dart';

class InscriptionApp extends StatelessWidget {
  const InscriptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Inscription')),
        body: const InscriptionScreen(),
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});
  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0), // Ajoutez ici l'espace
            child: const Text(
              'Inscription',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InscriptionWidget(),
                  ],
                ),
              ),
            ),
          ),
          Footer(), // Le footer sera collé en bas
        ],
      ),
    );
  }
}
