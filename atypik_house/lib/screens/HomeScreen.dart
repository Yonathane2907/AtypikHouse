import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/commons/cookie_widget.dart';
import '../widgets/commons/drawer_widget.dart';
import '../widgets/commons/footer.dart';
import '../widgets/commons/carousel_section.dart';
import '../widgets/commons/villa_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkAuthentication();
    checkCookieConsent();  // Ajouter cette ligne
  }

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  Future<void> saveCookieConsent(bool accepted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cookie_consent', accepted);
  }

  Future<bool> getCookieConsent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('cookie_consent') ?? false;
  }

  void checkCookieConsent() async {
    bool accepted = await getCookieConsent();
    if (!accepted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => CookieConsentDialog(onAccept: () async {
            await saveCookieConsent(true);
          }),
        );
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Atypik House',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSection(),
            const VillaSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
