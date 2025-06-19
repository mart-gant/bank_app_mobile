import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  Future<void> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://your-api.com/api/login'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$email:$password'))}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed');
    }

    // TODO: Save token/response if needed
  }

  Future<void> register(String email, String password, String name) async {
    final response = await client.post(
      Uri.parse('https://your-api.com/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Registration failed');
    }

    // TODO: Save user data or token if needed
  }
}
