import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 32)),
              const SizedBox(height: 32),
              SizedBox(
                width: 250,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
