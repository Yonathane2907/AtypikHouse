import 'package:atypik_house/providers/category_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 1000, name: TABLET),
            const Breakpoint(start: 1001, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      title: "AtypikHouse",
      routerConfig: RouterService.getRouter(),
    );
  }
}