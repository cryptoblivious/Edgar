import 'dart:math';

import 'package:flutter/material.dart';

class LoadingSubscreen extends StatelessWidget {
  final String? message;
  late final String currentMessage;

  LoadingSubscreen({super.key, this.message}) {
    currentMessage = message ?? _randomizeMessage();
  }

  static final List<String> loadingScreenMessages = [
    'Bringing out the cookbooks...',
    'Scrubbing the pots and pans...',
    'Warming up the oven...',
    'Eating the leftovers...',
    'Baking fresh bread...',
    'Spicing up the flavors...',
    'Tasting simmering soup...',
    'Savoring homemade desserts...',
    'Sharing the delicious feast...',
    'Preparing the secret recipe...',
    'Simmering aromatic spices...',
    'Chopping fresh ingredients...',
    'Whisking creamy sauce...',
    'Steaming delectable dumplings...',
    'Garnishing dishes with love...',
    'Indulging in culinary creativity...',
    'Tasting the melting chocolate...',
    'Grilling the juicy steaks...',
    'Roasting the tender vegetables...',
    'Experimenting with new flavors...',
    'Adding a pinch of magic...',
    'Plating an artful presentation...',
    'Stirring the bubbling pot...',
    'Creating culinary masterpieces...',
    'Inventing flavor combinations...',
    'Smelling the aroma of success...',
    'Enjoying the culinary journey...',
    'Spreading the joy of cooking...'
  ];

  static String _randomizeMessage() {
    return loadingScreenMessages[Random().nextInt(loadingScreenMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      child: Align(
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
    );
  }
}
