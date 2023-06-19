import 'package:flutter/material.dart';

void showGenericSnackbar(BuildContext context, {String? message}) {
  final String snackMessage = message ?? 'Generic Snackbar Message!';

  final RenderBox? overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
  final offset = overlay?.globalToLocal(Offset.zero);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          snackMessage,
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
