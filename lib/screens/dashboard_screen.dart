import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? error;

  final _authService = AuthService(baseUrl: 'https://your-api-url.com');

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final data = await _authService.getUserData();
      setState(() => userData = data);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : error != null
                ? Text('Błąd: $error')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Witaj, ${userData?['name'] ?? 'Użytkowniku'}', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      Text('Email: ${userData?['email']}'),
                      Text('Typ konta: ${userData?['account_type']}'),
                    ],
                  ),
      ),
    );
  }
}
