import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<File> exportUserDataToPDF(String email, String name) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('User Data', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            pw.Text('Name: $name'),
            pw.Text('Email: $email'),
          ],
        ),
      ),
    ),
  );

  final outputDir = await getApplicationDocumentsDirectory();
  final outputFile = File('${outputDir.path}/user_data.pdf');
  await outputFile.writeAsBytes(await pdf.save());

  return outputFile;
}
