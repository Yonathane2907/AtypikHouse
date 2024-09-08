import 'package:flutter/material.dart';

class CookieConsentDialog extends StatelessWidget {
  final VoidCallback onAccept;

  const CookieConsentDialog({required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Acceptation des cookies'),
      content: const Text(
          'Nous utilisons des cookies pour améliorer votre expérience. Acceptez-vous l\'utilisation des cookies ?'),
      actions: [
        TextButton(
          child: const Text('Refuser'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Accepter'),
          onPressed: () {
            onAccept();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
