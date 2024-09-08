import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserModel with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  String get role => _user?.role ?? '';

  void login(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
