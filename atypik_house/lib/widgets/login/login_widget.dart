import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Regex pour validation de l'email
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
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
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
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
                      // Afficher un SnackBar pour indiquer que la connexion a réussi
                      _showSnackBar('Connexion réussie.');
                      // Redirection vers la page d'accueil
                      GoRouter.of(context).go('/');
                    } else {
                      setState(() {
                        _errorMessage = 'Erreur de connexion. Veuillez réessayer.';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'Une erreur s\'est produite. Veuillez réessayer plus tard.';
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
