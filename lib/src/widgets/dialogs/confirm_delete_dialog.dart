import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'.tr),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          // Dismisses the dialog and returns false
          child: Text('Cancel'.tr),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          // Dismisses the dialog and returns true
          child: Text('Delete'.tr),
        ),
      ],
    );
  }
}
