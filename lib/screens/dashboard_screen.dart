import 'package:flutter/material.dart';
import 'package:bank_app_mobile/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final authHeader = await AuthService.getAuthHeader();
    final response = await http.get(
      Uri.parse('https://yourapi.com/api/settings/user'),
      headers: {'Authorization': authHeader ?? ''},
    );

    if (response.statusCode == 200) {
      setState(() => userData = json.decode(response.body));
    } else {
      setState(() => userData = {'error': 'Failed to load data'});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: userData!.containsKey('error')
          ? Center(child: Text(userData!['error']))
          : ListView(
        children: userData!.entries.map((e) => ListTile(title: Text('${e.key}'), subtitle: Text('${e.value}'))).toList(),
      ),
    );
  }
}
