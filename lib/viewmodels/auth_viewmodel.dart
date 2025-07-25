import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? error;

  Future<bool> loginWithWebAuthn() async {
    isLoading = true;
    notifyListeners();
    final result = await AuthService().loginWithWebAuthn();
    isLoading = false;
    notifyListeners();
    return result;
  }
}
