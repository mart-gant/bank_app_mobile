import 'package:flutter_test/flutter_test.dart';
import 'package:bank_app_mobile/services/pdf_exporter.dart';
import 'dart:io';

void main() {
  test('PDF export returns valid file', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    final file = await exportUserDataToPDF('test@example.com', 'Test User');

    expect(file.existsSync(), isTrue);
    expect(file.path.endsWith('.pdf'), isTrue);
    expect(await file.length(), greaterThan(0));

    // Cleanup
    if (file.existsSync()) {
      file.deleteSync();
    }
  });

  test('PDF export with empty data still creates file', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    final file = await exportUserDataToPDF('', '');

    expect(file.existsSync(), isTrue);
    expect(file.path.endsWith('.pdf'), isTrue);

    // Cleanup
    if (file.existsSync()) {
      file.deleteSync();
    }
  });
}
