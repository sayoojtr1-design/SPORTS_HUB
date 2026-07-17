import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "Remove",
    String cancelText = "Cancel",
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(title),
          content: Text(message),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(cancelText),
            ),

            ElevatedButton(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}