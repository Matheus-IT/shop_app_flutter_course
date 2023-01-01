import 'package:flutter/material.dart';

void presentWarningDialog({
  required BuildContext context,
  String title = 'Something went wrong',
  String content = 'There was a problem',
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
