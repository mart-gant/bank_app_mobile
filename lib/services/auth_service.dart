import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  void dispose() {
    client.close();
  }

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
    // Validate inputs
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception('All fields are required');
    }
    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    final url = Uri.parse('https://api.your-bank-app.com/api/v1/auth/register');

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
        // Registration successful
        return;
      } else {
        final errorMessage = response.body.isNotEmpty 
            ? response.body 
            : 'Registration failed with status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }


  Future<void> login(String email, String password) async {
    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }
    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    final url = Uri.parse('https://api.your-bank-app.com/api/v1/auth/login');

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
        // Login successful
        // You can decode JWT token or user data here
        // final data = jsonDecode(response.body);
        return;
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        final errorMessage = response.body.isNotEmpty 
            ? response.body 
            : 'Login failed with status ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
