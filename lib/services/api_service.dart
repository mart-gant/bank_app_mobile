import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> getUserSettings() async {
    final response = await client.get(
      Uri.parse('https://your-api.com/api/settings/user'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer your_token', // Add token if needed
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch user settings');
    }
  }
}
