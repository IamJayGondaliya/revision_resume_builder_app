import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:revision_resume_builder_app/globals/globals.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<Uint8List> getPdf() async {
    // 1. Create an object of Document
    pw.Document pdf = pw.Document();

    // 2. Add pages
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: Globals.globals.allUsers
                .map(
                  (e) => pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.SizedBox(
                          height: 100,
                          width: 100,
                          child: pw.Image(
                            pw.MemoryImage(
                              e.image!.readAsBytesSync(),
                            ),
                          ),
                        ),
                        pw.Text(e.name ?? "UNKNOWN"),
                        pw.Text(e.contact ?? "NOT SET"),
                        pw.Text(e.email ?? "NOT SET"),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );

    // 3. Generate Uint8List using save() method.
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pdf Page"),
      ),
      body: PdfPreview(
        build: (format) => getPdf(),
      ),
    );
  }
}
