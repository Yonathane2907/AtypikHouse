import 'package:atypik_house/providers/category_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/router_service.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
      ),
    ],
    child: const AtypikHouse(),
  ),
);

class AtypikHouse extends StatelessWidget {
  const AtypikHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "AtypikHouse",
      routerConfig: RouterService.getRouter(),
    );
  }
}