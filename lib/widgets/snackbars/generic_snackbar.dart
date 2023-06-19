import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void showGenericSnackbar(BuildContext context, {String? message}) {
  final String snackMessage = message ?? 'Generic Snackbar Message!';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: AutoSizeText(
          snackMessage,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
