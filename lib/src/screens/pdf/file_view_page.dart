import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class FileViewPage extends StatefulWidget {
  const FileViewPage({super.key, required this.files, this.index = 0});
  final List<File> files;
  final int index;

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  late int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final file = widget.files[index];
    final extension = file.path.split('.').last;
    final actions = widget.files.length > 1 ? <Widget>[] : null;
    if(actions != null) {
      if(index > 0) {
        actions.add(TextButton(onPressed: showPrevFile, child: Text(
            '< Prev'.tr)));
      }
      if(index < (widget.files.length - 1)) {
        actions.add(TextButton(onPressed: showNextFile, child: Text(
            'Next >'.tr)));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('File Viewer'.tr),
        actions: actions,
      ),
      body: extension == 'pdf' ? PDFView(key: Key(file.path), filePath: file.path,)
          : Image(
        image: FileImage(file), width: MediaQuery.of(context).size.width,)
    );
  }

  void showPrevFile() {
    setState(() {
      index -= 1;
    });
  }

  void showNextFile() {
    setState(() {
      index += 1;
    });
  }
}
