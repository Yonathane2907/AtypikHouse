import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  String? _selectedRole;

  final RegExp _emailRegExp = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
    caseSensitive: false,
  );

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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
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
          ),
          const SizedBox(height: 16), // Espace entre les champs
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
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
          ),
          const SizedBox(height: 16), // Espace entre les champs
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
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
          ),
          const SizedBox(height: 16), // Espace entre les champs
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Entrez votre email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre email';
                } else if (!_emailRegExp.hasMatch(value)) {
                  return 'Veuillez saisir un email valide';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16), // Espace entre les champs
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
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
          ),
          const SizedBox(height: 16),
      Container(
        width:300,
         child: DropdownButtonFormField<String>(
            value: _selectedRole,
            hint: const Text('Sélectionnez un rôle'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner un rôle';
              }
              return null;
            },
            items: <String>['Locataire', 'Propriétaire'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final nom = _nomController.text;
                  final prenom = _prenomController.text;
                  final adresse = _adresseController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final role = _selectedRole;

                  try {
                    final resultMessage = await UserService().inscription(nom, prenom, adresse, email, password, role!);
                    _showSnackBar(resultMessage);
                    if (resultMessage == 'Inscription réussie.') {
                      GoRouter.of(context).go('/');
                    }
                  } catch (e) {
                    _showSnackBar('Une erreur s\'est produite. Veuillez réessayer plus tard.');
                  }
                }
              },
              child: const Text('S\'inscrire'),
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
