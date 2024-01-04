import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

// A simple screen for viewing PDFs
class PDFViewPage extends StatelessWidget {
  final File file;

  const PDFViewPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer'.tr)),
      body: PDFView(filePath: file.path),
    );
  }
}