import 'package:flutter/material.dart';
import 'package:bank_app_mobile/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _accountType = 'regular'; // or 'demo'

  void _register() async {
    bool success = await AuthService.register(
      _emailController.text,
      _passwordController.text,
      _accountType,
    );

    if (success) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Column(
        children: [
          TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          DropdownButton<String>(
            value: _accountType,
            items: ['regular', 'demo'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            onChanged: (value) => setState(() => _accountType = value!),
          ),
          ElevatedButton(onPressed: _register, child: Text('Register')),
        ],
      ),
    );
  }
}
