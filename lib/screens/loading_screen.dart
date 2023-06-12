import 'dart:math';

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key});

  static final List<String> loadingScreenMessages = ['Bringing out the cookbooks...', 'Cleaning the pots and pans...', 'Warming up the oven...'];

  static String _randomizeMessage() {
    return loadingScreenMessages[Random().nextInt(loadingScreenMessages.length)];
  }

  final String currentMessage = _randomizeMessage();

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
              Text(currentMessage, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 32)),
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
