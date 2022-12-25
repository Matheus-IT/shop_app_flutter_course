import 'package:flutter/material.dart';

void presentWarningFailToggleFavorites(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Something went wrong'),
      content: const Text('There was a problem when trying to toggle a product as favorite'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
