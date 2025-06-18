import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;
  AuthService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final credentials = base64Encode(utf8.encode('$email:$password'));
    final response = await http.get(
      Uri.parse('$baseUrl/api/settings/user'),
      headers: {'Authorization': 'Basic $credentials'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  Future<void> register(String email, String password, String accountType) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'account_type': accountType,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}
