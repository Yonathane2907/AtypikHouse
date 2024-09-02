import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart'; // Assurez-vous d'importer le bon fichier

class AdminServicePage extends StatefulWidget {
  @override
  _AdminServicePageState createState() => _AdminServicePageState();
}

class _AdminServicePageState extends State<AdminServicePage> {
  List<dynamic> _accounts = [];
  final List<String> _roles = ['Propriétaire', 'Locataire', 'admin'];
  String _selectedRole = 'Propriétaire';
  bool _isAdmin = false;  // Indicateur pour vérifier si l'utilisateur est un admin
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://localhost:3000';

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> _checkUserRole() async {
    final token = await getToken();
    if (token == null) {
      GoRouter.of(context).go('/unauthorized');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/admin'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedToken = jwtDecode(token);
        final role = decodedToken['user']['role'] as String;

        if (role == 'admin') {
          setState(() {
            _isAdmin = true;
          });
          _fetchAccounts();
        } else {
          GoRouter.of(context).go('/unauthorized');
        }
      } else {
        GoRouter.of(context).go('/unauthorized');
      }
    } catch (e) {
      GoRouter.of(context).go('/unauthorized');
    }
  }

  Map<String, dynamic> jwtDecode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    return jsonDecode(utf8.decode(payload));
  }

  Future<void> _fetchAccounts() async {
    if (!_isAdmin) return;
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/listAccounts'));
      if (response.statusCode == 200) {
        setState(() {
          _accounts = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load accounts');
      }
    } catch (e) {
      _showSnackBar('Erreur lors du chargement des comptes : $e');
    }
  }

  Future<void> _deleteAccount(int id) async {
    if (!_isAdmin) return;
    try {
      final response = await http.delete(Uri.parse('$baseUrl/api/deleteAccount/$id'));
      if (response.statusCode == 200) {
        _showSnackBar('Compte supprimé avec succès');
        _fetchAccounts();
      } else {
        throw Exception('Erreur lors de la suppression du compte');
      }
    } catch (e) {
      _showSnackBar('Erreur lors de la suppression du compte : $e');
    }
  }

  Future<void> _updateAccount(int id_user, String? nom, String? prenom, String? adresse, String? email, String? password, String? role) async {
    if (!_isAdmin) return;

    final updateFields = <String, dynamic>{};
    if (nom != null && nom.isNotEmpty) updateFields['nom'] = nom;
    if (prenom != null && prenom.isNotEmpty) updateFields['prenom'] = prenom;
    if (adresse != null && adresse.isNotEmpty) updateFields['adresse'] = adresse;
    if (email != null && email.isNotEmpty) updateFields['email'] = email;
    if (password != null && password.isNotEmpty) updateFields['password'] = password;
    if (role != null && role.isNotEmpty) updateFields['role'] = role;

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/updateAccount/$id_user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updateFields),
      );

      if (response.statusCode == 200) {
        _showSnackBar('Compte mis à jour avec succès');
        _fetchAccounts();
      } else {
        throw Exception('Erreur lors de la mise à jour du compte');
      }
    } catch (e) {
      _showSnackBar('Erreur lors de la mise à jour du compte : $e');
    }
  }

  Future<void> _addAccount(String nom, String prenom, String adresse, String email, String password, String role) async {
    if (!_isAdmin) return;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/createAccount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'nom': nom,
          'prenom': prenom,
          'adresse': adresse,
          'email': email,
          'password': password,
          'role': role,
        }),
      );
      if (response.statusCode == 201) {
        _showSnackBar('Compte ajouté avec succès');
        _fetchAccounts();
      } else {
        throw Exception('Erreur lors de l\'ajout du compte');
      }
    } catch (e) {
      _showSnackBar('Erreur lors de l\'ajout du compte : $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddAccountDialog() {
    if (!_isAdmin) return;
    final nomController = TextEditingController();
    final prenomController = TextEditingController();
    final adresseController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String selectedRole = _roles[0];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ajouter un Compte'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: adresseController,
                decoration: InputDecoration(labelText: 'Adresse'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
              ),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Rôle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final nom = nomController.text;
                final prenom = prenomController.text;
                final adresse = adresseController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final role = selectedRole;

                if (email.isNotEmpty && password.isNotEmpty && role.isNotEmpty && nom.isNotEmpty && prenom.isNotEmpty && adresse.isNotEmpty) {
                  _addAccount(nom, prenom, adresse, email, password, role);
                } else {
                  _showSnackBar('Veuillez remplir tous les champs');
                }

                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(int id_user, String nom, String prenom, String adresse, String email, String currentRole) {
    if (!_isAdmin) return;
    final nomController = TextEditingController(text: nom);
    final prenomController = TextEditingController(text: prenom);
    final adresseController = TextEditingController(text: adresse);
    final emailController = TextEditingController(text: email);
    final passwordController = TextEditingController();
    String selectedRole = currentRole;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier le Compte'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: adresseController,
                decoration: InputDecoration(labelText: 'Adresse'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
              ),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Rôle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final nom = nomController.text;
                final prenom = prenomController.text;
                final adresse = adresseController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final role = selectedRole;

                if (email.isNotEmpty && role.isNotEmpty) {
                  _updateAccount(id_user, nom, prenom, adresse, email, password, role);
                } else {
                  _showSnackBar('Veuillez remplir tous les champs');
                }

                Navigator.of(context).pop();
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdmin) {
      return Scaffold(
        body: Center(
          child: Text(
            'Chargement...',  // Affiche un texte pendant que la vérification du rôle est en cours
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Comptes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddAccountDialog,
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _accounts.length,
              itemBuilder: (context, index) {
                final account = _accounts[index];
                final email = account['email'] ?? 'Email non disponible';
                final role = account['role'] ?? 'Rôle non disponible';
                final idUser = account['id_user'] ?? -1;

                return ListTile(
                  title: Text(email),
                  subtitle: Text('Rôle: $role'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          if (idUser != -1) {
                            _showEditDialog(idUser, account['nom'] ?? '', account['prenom'] ?? '', account['adresse'] ?? '', email, role);
                          } else {
                            _showSnackBar('Identifiant utilisateur non disponible');
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          if (idUser != -1) {
                            _deleteAccount(idUser);
                          } else {
                            _showSnackBar('Identifiant utilisateur non disponible');
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Footer(),  // Le footer sera collé en bas
        ],
      ),
    );
  }
}
