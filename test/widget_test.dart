import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bank_app_mobile/main.dart'; // Upewnij się, że istnieje i zawiera klasę BankApp

void main() {
  testWidgets('App builds and shows MaterialApp', (WidgetTester tester) async {
 await tester.pumpWidget(const BankApp(themeMode: ThemeMode.system));

    // Sprawdź, czy MaterialApp został załadowany
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
