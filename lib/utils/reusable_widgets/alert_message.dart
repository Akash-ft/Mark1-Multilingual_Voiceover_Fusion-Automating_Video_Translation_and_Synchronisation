import 'package:flutter/material.dart';

void showMessageDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onOkPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onOkPressed();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
