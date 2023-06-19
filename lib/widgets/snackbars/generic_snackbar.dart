import 'package:flutter/material.dart';

void showGenericSnackbar(BuildContext context, {String? message}) {
  final String snackMessage = message ?? 'Generic Snackbar Message!';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(snackMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
    ),
  );
}
