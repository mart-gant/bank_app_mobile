import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String accountType = 'regular';

  bool isLoading = false;
  String? error;

  final _authService = AuthService(baseUrl: 'https://your-api-url.com');

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final user = await _authService.register(
        _emailController.text,
        _passwordController.text,
        accountType,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Zarejestruj się', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty ? 'Wprowadź email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Hasło'),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Wprowadź hasło' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: accountType,
                  decoration: const InputDecoration(labelText: 'Typ konta'),
                  items: const [
                    DropdownMenuItem(value: 'regular', child: Text('Konto zwykłe')),
                    DropdownMenuItem(value: 'demo', child: Text('Konto demo')),
                  ],
                  onChanged: (value) => setState(() => accountType = value!),
                ),
                const SizedBox(height: 24),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(error!, style: const TextStyle(color: Colors.red)),
                  ),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _register,
                        child: const Text('Zarejestruj'),
                      ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Masz już konto? Zaloguj się'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
