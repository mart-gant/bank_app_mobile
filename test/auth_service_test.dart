import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:bank_app_mobile/services/auth_service.dart';

void main() {
  group('AuthService', () {
    test('login succeeds with 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{}', 200);
      });

      final authService = AuthService(client: mockClient);
      expect(() => authService.login('user@example.com', 'password123'), returnsNormally);
    });

    test('login fails with 401', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Unauthorized', 401);
      });

      final authService = AuthService(client: mockClient);
      expect(() => authService.login('user@example.com', 'wrongpassword'), throwsException);
    });

    test('register succeeds with 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{}', 200);
      });

      final authService = AuthService(client: mockClient);
      expect(() => authService.register('user@example.com', 'pass123', 'User'), returnsNormally);
    });

    test('register fails with 400', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Bad Request', 400);
      });

      final authService = AuthService(client: mockClient);
      expect(() => authService.register('user@example.com', '', ''), throwsException);
    });
  });
}
