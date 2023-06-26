import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingScreen extends StatelessWidget {
  final String? message;
  late final String currentMessage;

  LoadingScreen({super.key, this.message}) {
    currentMessage = message ?? _randomizeMessage();
  }

  static final Set<String> loadingScreenMessages = {
    'Bringing out the cookbooks...',
    'Scrubbing pots and pans...',
    'Warming up the oven...',
    'Eating the leftovers...',
    'Baking fresh bread...',
    'Spicing up the flavors...',
    'Tasting simmering soup...',
    'Savoring homemade desserts...',
    'Sharing the delicious feast...',
    'Picking the secret ingredient...',
    'Simmering aromatic spices...',
    'Chopping fresh vegetables...',
    'Whisking creamy sauce...',
    'Steaming delectable dumplings...',
    'Garnishing dishes with love...',
    'Indulging in culinary creativity...',
    'Tasting melting chocolate...',
    'Slicing fresh fruit...',
    'Grilling juicy steaks...',
    'Roasting tender vegetables...',
    'Experimenting with new flavors...',
    'Adding a pinch of magic...',
    'Plating an artful presentation...',
    'Stirring the bubbling pot...',
    'Creating culinary masterpieces...',
    'Inventing flavor combinations...',
    'Smelling the aroma of success...',
    'Enjoying the culinary journey...',
    'Spreading the joy of cooking...',
    'Serving up a delicious meal...',
    'Savoring the fruits of labor...',
    'Satisfying the hunger...',
  };

  static String _randomizeMessage() {
    List<String> loadingScreenMessagesList = LoadingScreen.loadingScreenMessages.toList();
    return loadingScreenMessagesList[Random().nextInt(loadingScreenMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
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
