import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/commons/appbar_widget.dart';
import '../services/api/user_service.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/login/login_widget.dart';
import '../widgets/commons/footer.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              'Connexion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginWidget(),
                  // Ajoutez d'autres widgets ici si nécessaire
                ],
              ),
            ),
          ),
          Footer(), // Le footer sera collé en bas
        ],
      ),
    );
  }
}
