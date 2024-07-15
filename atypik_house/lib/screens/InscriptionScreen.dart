import 'package:atypik_house/widgets/login/login_widget.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widgets/commons/appbar_widget.dart';
import '../services/api/user_service.dart';
import '../widgets/login/inscription_widget.dart';

void main() {
  runApp(const InscriptionApp());
}

class InscriptionApp extends StatelessWidget {
  const InscriptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: const InscriptionScreen(),
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});
  @override
  State<InscriptionScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<InscriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const InscriptionWidget(),
          ],
        ),
      ),
    );
  }
}
