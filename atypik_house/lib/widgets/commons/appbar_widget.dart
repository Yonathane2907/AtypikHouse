import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).location;
    final isHome = currentPath == '/';

    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
