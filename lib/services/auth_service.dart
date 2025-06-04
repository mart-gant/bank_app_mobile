import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final storage = FlutterSecureStorage();

  static Future<bool> register(String email, String password, String accountType) async {
    final response = await http.post(
      Uri.parse('https://yourapi.com/api/register'),
      body: {'email': email, 'password': password, 'type': accountType},
    );
    return response.statusCode == 200;
  }

  static Future<bool> login(String email, String password) async {
    final basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    final response = await http.get(
      Uri.parse('https://yourapi.com/api/settings/user'),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      await storage.write(key: 'auth', value: basicAuth);
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getAuthHeader() async {
    return await storage.read(key: 'auth');
  }
}
