import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/app_database.dart';
import '../services/pdf_exporter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = ThemeMode.values.firstWhere((e) => e.name == savedTheme);
    });
  }

  Future<void> _changeTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
    setState(() => _themeMode = mode);
  }

  Future<void> _clearDatabase() async {
    final db = AppDatabase();
    await db.delete(db.users).go();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Database cleared')),
    );
  }

  Future<void> _exportData() async {
    final db = AppDatabase();
    final users = await db.getAllUsers();
    if (users.isNotEmpty) {
      final file = await exportUserDataToPDF(users.first.email, users.first.name);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to ${file.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light Mode'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _themeMode,
              onChanged: (mode) {
                if (mode != null) _changeTheme(mode);
              },
            ),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _themeMode,
              onChanged: (mode) {
                if (mode != null) _changeTheme(mode);
              },
            ),
          ),
          ListTile(
            title: const Text('System Default'),
            leading: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _themeMode,
              onChanged: (mode) {
                if (mode != null) _changeTheme(mode);
              },
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _exportData,
            child: const Text('Export to PDF'),
          ),
          ElevatedButton(
            onPressed: _clearDatabase,
            child: const Text('Clear Local Database'),
          ),
        ],
      ),
    );
  }
}
