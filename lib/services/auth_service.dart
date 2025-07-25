import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http; // Import http package

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();
  final http.Client client; // Add a client field

  // Update the constructor to accept a client
  AuthService({http.Client? client}) : client = client ?? http.Client();

  Future<bool> loginWithWebAuthn() async {
    final isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) return false;
    final didAuthenticate = await auth.authenticate(
      localizedReason: 'Please authenticate to log in',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    return didAuthenticate;
  }

 Future<void> register(String email, String password, String name) async {
  final url = Uri.parse('https://your-backend-url/api/v1/auth/register'); // 🔁 Podmień na swój adres backendu

  try {
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Rejestracja zakończona sukcesem!');
      // Tu możesz zapisać token lub przekierować użytkownika
    } else {
      print('Błąd rejestracji: ${response.statusCode} ${response.body}');
      throw Exception('Rejestracja nie powiodła się');
    }
  } catch (e) {
    print('Błąd podczas rejestracji: $e');
    throw Exception('Rejestracja nie powiodła się: $e');
  }
}


  // Add the login method
  Future<void> login(String email, String password) async {
  final url = Uri.parse('https://your-backend-url/api/v1/auth/login'); // 🔁 Zastąp rzeczywistym adresem

  try {
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Logowanie zakończone sukcesem!');
      // Możesz tu zdekodować token JWT lub dane użytkownika
      // final data = jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Nieprawidłowy email lub hasło');
    } else {
      throw Exception('Logowanie nie powiodło się. Kod: ${response.statusCode}');
    }
  } catch (e) {
    print('Błąd podczas logowania: $e');
    throw Exception('Logowanie nie powiodło się: $e');
  }
}

}
