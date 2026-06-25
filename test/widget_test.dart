import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bank_app_mobile/main.dart';

void main() {
  testWidgets('App builds and shows MaterialApp', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    await tester.pumpWidget(const BankApp(themeMode: ThemeMode.system));

    // Check if MaterialApp is loaded
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
