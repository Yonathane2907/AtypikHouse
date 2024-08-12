import 'package:atypik_house/widgets/login/login_widget.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../widgets/commons/appbar_widget.dart';
import '../services/api/user_service.dart';
import '../widgets/commons/drawer_widget.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginWidget(),
          ],
        ),
      ),
    );
  }
}
