import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importer le package dotenv
import 'services/router_service.dart';
import 'services/api/user_service.dart';

Future<void> main() async {
  // Charger les variables d'environnement
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        // Ajoutez d'autres providers ici si nécessaire
      ],
      child: const AtypikHouse(),
    ),
  );
}

class AtypikHouse extends StatelessWidget {
  const AtypikHouse({super.key});

  @override
  Widget build(BuildContext context) {
    final router = RouterService.getRouter();

    return MaterialApp.router(
      title: "AtypikHouse",
      routerConfig: router,
      // Ajoutez d'autres configurations pour MaterialApp.router si nécessaire
    );
  }
}
