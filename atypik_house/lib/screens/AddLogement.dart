import 'dart:io' as io;
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ImagePickerUpload extends StatefulWidget {
  @override
  _ImagePickerUploadState createState() => _ImagePickerUploadState();
}

class _ImagePickerUploadState extends State<ImagePickerUpload> {
  // Variable pour stocker l'URL de l'image
  String? _imageUrl;

  // Fonction pour sélectionner une image
  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Code pour le web
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final bytes = file.bytes;

        if (bytes != null) {
          final url = html.Url.createObjectUrlFromBlob(html.Blob([bytes]));
          setState(() {
            _imageUrl = url;
          });
        }
      }
    } else {
      // Code pour mobile
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageUrl = pickedFile.path;
        });
      }
    }
  }

  // Fonction pour uploader une image
  Future<void> _uploadImage() async {
    if (_imageUrl == null) return;

    try {
      Uri uri = Uri.parse('http://localhost:3000/api/upload'); // Remplace par l'URL de ton serveur

      if (kIsWeb) {
        // Code pour le web
        final file = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );

        if (file != null) {
          final bytes = file.files.first.bytes;
          if (bytes != null) {
            final request = http.MultipartRequest('POST', uri)
              ..files.add(http.MultipartFile.fromBytes(
                'image',
                bytes,
                filename: file.files.first.name,
              ));

            final response = await request.send();

            if (response.statusCode == 200) {
              print('Upload réussi');
            } else {
              print('Upload échoué');
            }
          }
        }
      } else {
        // Code pour mobile
        final file = io.File(_imageUrl!);
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();

        final request = http.MultipartRequest('POST', uri)
          ..files.add(http.MultipartFile(
            'image',
            stream,
            length,
            filename: file.uri.pathSegments.last,
          ));

        final response = await request.send();

        if (response.statusCode == 200) {
          print('Upload réussi');
        } else {
          print('Upload échoué');
        }
      }
    } catch (e) {
      print('Erreur lors du téléchargement: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageUrl == null
                ? Text('No image selected.')
                : kIsWeb
                ? Image.network(_imageUrl!)
                : Image.file(io.File(_imageUrl!)),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
