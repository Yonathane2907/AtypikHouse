import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/api/user_service.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 300, // Largeur fixe pour le formulaire
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Entrez votre email'),
              validator: (value) {
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
              decoration: const InputDecoration(hintText: 'Entrez votre mot de passe'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre mot de passe';
                }
                return null;
              },
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  try {
                    final success = await UserService().login(email, password);
                    if (success) {
                      _showSnackBar('Connexion réussie.');
                      GoRouter.of(context).go('/');
                    } else {
                      setState(() {
                        _errorMessage = 'Erreur de connexion. Veuillez réessayer.';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = e.toString(); // Afficher le message d'erreur exact
                    });
                  }
                }
              },
              child: const Text('Connexion'),
            ),
          ),
        ],
      ),
    );
  }
}
