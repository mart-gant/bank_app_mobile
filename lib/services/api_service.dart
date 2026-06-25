import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  void dispose() {
    client.close();
  }

  Future<Map<String, dynamic>> getUserSettings() async {
    final url = Uri.parse('https://api.your-bank-app.com/api/settings/user');
    
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer your_token', // Add token if needed
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        final errorMessage = response.body.isNotEmpty 
            ? response.body 
            : 'Failed to fetch user settings. Status: ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to fetch user settings: ${e.toString()}');
    }
  }
}
