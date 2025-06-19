import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeModeStr = prefs.getString('themeMode') ?? 'system';
  final themeMode = ThemeMode.values.firstWhere((e) => e.name == themeModeStr);
  
  runApp(BankApp(themeMode: themeMode));
}

class BankApp extends StatelessWidget {
  final ThemeMode themeMode;

  const BankApp({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BankApp',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
