import 'package:flutter/foundation.dart';

/// In-memory prototype state. No account is created and no message is sent.
class DemoAuthController extends ChangeNotifier {
  static const demoCode = '123456';
  String email = '';
  String name = '';
  bool verified = false;

  void begin({required String email, String name = ''}) {
    this.email = email.trim();
    this.name = name.trim();
    verified = false;
    notifyListeners();
  }

  bool verify(String code) {
    if (email.isEmpty || code.trim() != demoCode) return false;
    verified = true;
    notifyListeners();
    return true;
  }

  void reset() {
    email = '';
    name = '';
    verified = false;
    notifyListeners();
  }
}

final demoAuth = DemoAuthController();
