import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;

import 'package:bank_app_mobile/services/auth_service.dart';

void main() {
  group('AuthService', () {
    test('login succeeds with 200', () async {
      final mockClient = http_testing.MockClient((request) async {
        return http.Response('{}', 200);
      });

      final authService = AuthService(client: mockClient);
      await expectLater(
        () => authService.login('user@example.com', 'password123'),
        returnsNormally,
      );
      authService.dispose();
    });

    test('login fails with 401', () async {
      final mockClient = http_testing.MockClient((request) async {
        return http.Response('Unauthorized', 401);
      });

      final authService = AuthService(client: mockClient);
      expect(
        () => authService.login('user@example.com', 'wrongpassword'),
        throwsException,
      );
      authService.dispose();
    });

    test('register succeeds with 200', () async {
      final mockClient = http_testing.MockClient((request) async {
        return http.Response('{}', 200);
      });

      final authService = AuthService(client: mockClient);
      await expectLater(
        () => authService.register('user@example.com', 'pass123', 'User'),
        returnsNormally,
      );
      authService.dispose();
    });

    test('register fails with 400', () async {
      final mockClient = http_testing.MockClient((request) async {
        return http.Response('Bad Request', 400);
      });

      final authService = AuthService(client: mockClient);
      expect(
        () => authService.register('user@example.com', '', ''),
        throwsException,
      );
      authService.dispose();
    });

    test('login with empty email throws exception', () async {
      final authService = AuthService();
      expect(
        () => authService.login('', 'password123'),
        throwsException,
      );
      authService.dispose();
    });

    test('register with invalid email throws exception', () async {
      final authService = AuthService();
      expect(
        () => authService.register('invalid-email', 'pass123', 'User'),
        throwsException,
      );
      authService.dispose();
    });
  });
}
