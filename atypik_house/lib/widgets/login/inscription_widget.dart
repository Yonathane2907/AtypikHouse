import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../services/api/user_service.dart';
class InscriptionWidget extends StatefulWidget {
  const InscriptionWidget({super.key});

  @override
  _InscriptionWidgetState createState() => _InscriptionWidgetState();
}

class _InscriptionWidgetState extends State<InscriptionWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nomController,
            decoration: const InputDecoration(
              hintText: 'Entrez votre nom',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre nom';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _prenomController,
            decoration: const InputDecoration(
              hintText: 'Entrez votre prénom',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre prénom';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _adresseController,
            decoration: const InputDecoration(
              hintText: 'Entrez votre adresse',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre adresse';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Entrez votre email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Entrez votre mot de passe',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre mot de passe';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async{
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  final nom = _nomController.text;
                  final prenom = _prenomController.text;
                  final adresse = _adresseController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  // Process data.
                  await UserService().inscription(nom, prenom, adresse, email, password);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InscriptionWidget(),
    );
  }
}
