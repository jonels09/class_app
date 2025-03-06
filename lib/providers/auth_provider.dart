import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = true;
  String _userName = 'Jean Dupont';
  String _userRole = 'Professeur de Mathématiques';

  bool get isAuthenticated => _isAuthenticated;
  String get userName => _userName;
  String get userRole => _userRole;

  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'jean.dupont@education.fr' && password == 'password') {
      _isAuthenticated = true;
      _userName = 'Jean Dupont';
      _userRole = 'Professeur de Mathématiques';
      notifyListeners();
      return true;
    }

    return false;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
