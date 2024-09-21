import 'dart:convert';
import 'dart:io' as io;
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/commons/drawer_widget.dart';

class AddAccommodation extends StatefulWidget {
  @override
  _AddAccommodationState createState() => _AddAccommodationState();
}

class _AddAccommodationState extends State<AddAccommodation> {
  String? _imageUrl;
  Uint8List? _webImageBytes;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _bedsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime _creationDate = DateTime.now();
  bool _isLoading = false;
  bool _isOwner = false;

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
      final decodedToken = jwtDecode(token);
      final role = decodedToken['user']['role'] as String;

      if (role == 'Propriétaire') {
        setState(() {
          _isOwner = true;
        });
      } else {
        Navigator.of(context).pushReplacementNamed('/unauthorized');
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed('/unauthorized');
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

  Future<void> _pickImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          _imageUrl = file.name;
          _webImageBytes = file.bytes;
        });
      }
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageUrl = pickedFile.path;
        });
      }
    }
  }

  bool _validateFields() {
    bool isValid = true;

    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _capacityController.text.isEmpty ||
        _bedsController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _imageUrl == null) {
      _showMessage(context, 'Tous les champs sont obligatoires, y compris l\'image.');
      isValid = false;
    }

    if (int.tryParse(_capacityController.text) == null ||
        int.tryParse(_bedsController.text) == null ||
        int.tryParse(_priceController.text) == null) {
      _showMessage(context, 'Capacité, Nombre de couchages et Prix doivent être des entiers.');
      isValid = false;
    }

    return isValid;
  }

  Future<void> _uploadAccommodation() async {
    if (!_isOwner) return;

    if (!_validateFields()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Uri uri = Uri.parse('http://localhost:3000/api/upload');

      final request = http.MultipartRequest('POST', uri)
        ..fields['titre'] = _titleController.text
        ..fields['description'] = _descriptionController.text
        ..fields['adresse'] = _addressController.text
        ..fields['capacite'] = _capacityController.text
        ..fields['nombre_couchage'] = _bedsController.text
        ..fields['prix'] = _priceController.text
        ..fields['date_creation'] = _creationDate.toIso8601String();

      if (_imageUrl != null) {
        if (kIsWeb) {
          if (_webImageBytes != null) {
            request.files.add(http.MultipartFile.fromBytes(
              'image',
              _webImageBytes!,
              filename: _imageUrl,
            ));
          }
        } else {
          final file = io.File(_imageUrl!);
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();

          request.files.add(http.MultipartFile(
            'image',
            stream,
            length,
            filename: file.uri.pathSegments.last,
          ));
        }
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        _showMessage(context, 'Logement ajouté avec succès !');
      } else {
        _showMessage(context, 'Erreur lors de l\'ajout du logement.');
      }
    } catch (e) {
      _showMessage(context, 'Erreur lors de la connexion au serveur : $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOwner) {
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
        title: Text('Ajouter un Logement'),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageUrl == null
                  ? Text('Aucune image sélectionnée.')
                  : kIsWeb
                  ? Image.memory(_webImageBytes!, height: 150)
                  : Image.file(io.File(_imageUrl!), height: 150),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choisir une Image'),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titre'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse'),
              ),
              TextField(
                controller: _capacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Capacité'),
              ),
              TextField(
                controller: _bedsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Nombre de couchages'),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Prix'),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _uploadAccommodation,
                child: Text('Enregistrer le Logement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
