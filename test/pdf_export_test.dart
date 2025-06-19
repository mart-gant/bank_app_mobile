import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:bank_app_mobile/services/pdf_exporter.dart';

void main() {
  test('PDF export returns valid file', () async {
    final file = await exportUserDataToPDF('test@example.com', 'Test User');

    expect(file.existsSync(), isTrue);
    expect(file.path.endsWith('.pdf'), isTrue);

    // Optional: cleanup
    file.deleteSync();
  });
}
