import 'package:flutter/material.dart';

void showButtonSnackbar(BuildContext context, [String? error]) {
  final errIsNull = error == null;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      width: 250,
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errIsNull) ...[
            const CircularProgressIndicator(),
            const SizedBox(width: 16.0)
          ],
          Text(errIsNull ? 'Loading...' : error,
              style: TextStyle(color: errIsNull ? Colors.white : Colors.red)),
        ],
      ),
      duration: const Duration(seconds: 12), // Adjust the duration as needed
    ),
  );
}
