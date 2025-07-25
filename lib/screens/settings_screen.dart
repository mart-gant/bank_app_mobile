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
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
    });
  }

  Future<void> _changeTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
    setState(() {
      _themeMode = mode;
    });
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            RadioGroup<ThemeMode>(
              value: _themeMode,
              onChanged: (mode) {
                if (mode != null) _changeTheme(mode);
              },
              children: [
                RadioOption(
                  value: ThemeMode.light,
                  label: 'Light Mode',
                ),
                RadioOption(
                  value: ThemeMode.dark,
                  label: 'Dark Mode',
                ),
                RadioOption(
                  value: ThemeMode.system,
                  label: 'System Default',
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _exportData,
              child: const Text('Export to PDF'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _clearDatabase,
              child: const Text('Clear Local Database'),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioGroup<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?> onChanged;
  final List<RadioOption<T>> children;

  const RadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.map((option) {
        return ListTile(
          title: Text(option.label),
          leading: Radio<T>(
            value: option.value,
            groupValue: value,
            onChanged: onChanged,
          ),
        );
      }).toList(),
    );
  }
}

class RadioOption<T> {
  final T value;
  final String label;

  RadioOption({
    required this.value,
    required this.label,
  });
}
