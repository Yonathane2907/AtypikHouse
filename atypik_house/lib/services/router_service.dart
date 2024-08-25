import 'package:atypik_house/screens/ContactScreen.dart';
import 'package:atypik_house/screens/HomeScreen.dart';
import 'package:atypik_house/screens/InscriptionScreen.dart';
import 'package:atypik_house/screens/LogementsScreen.dart';
import 'package:atypik_house/screens/AddLogement.dart';
import 'package:go_router/go_router.dart';
import '../screens/LoginScreen.dart';
import 'package:atypik_house/screens/AdminManage.dart';
import '../main.dart';
import '../screens/UnauthorisedScreen.dart';

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
        GoRoute(
          path: '/contact',
          name: 'contact',
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(
          path: '/logements',
          name: 'logements',
          builder: (context, state) => const LogementsScreen(),
        ),
        GoRoute(
          path: '/images',
          name: 'images',
          builder: (context, state) => ImagePickerUpload(),
        ),
        GoRoute(
          path: '/admin',
          name: 'admin',
          builder: (context, state) => AdminServicePage(),
        ),
        GoRoute(
          path: '/unauthorized',
          name: 'unauthorized',
          builder: (context, state) => UnauthorizedPage(),
        ),
      ],
    );
  }
}