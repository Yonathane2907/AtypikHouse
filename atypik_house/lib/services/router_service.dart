import 'package:atypik_house/screens/HomeScreen.dart';
import 'package:atypik_house/screens/InscriptionScreen.dart';
import 'package:go_router/go_router.dart';
import '../screens/LoginScreen.dart';
import '../main.dart';

class RouterService {
  // lister les routes
  static GoRouter getRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          /*
            path : schéma Web d'une route
              > la route / doit exister et est considérée comme la route d'accueil
            name : nom de la route
            builder permet de cibler un widget associé à la route
          */
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/inscription',
          name: 'inscription',
          builder: (context, state) => const InscriptionScreen(),
        ),
      ],
    );
  }
}