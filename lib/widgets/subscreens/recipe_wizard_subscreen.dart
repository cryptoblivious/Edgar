import 'package:flutter/material.dart';
import 'package:edgar/services/vendors/openai/completions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeWizardSubscreen extends StatefulWidget {
  const RecipeWizardSubscreen({Key? key}) : super(key: key);

  @override
  State<RecipeWizardSubscreen> createState() => _RecipeWizardSubscreenState();
}

class _RecipeWizardSubscreenState extends State<RecipeWizardSubscreen> {
  Stream<String>? completionStream;
  String text = '...';

  Future<void> handlePress() async {
    // TODO : Make this work with gradual completion
    setState(() {
      completionStream = onceUponATime();
      text = '';
    });

    await for (var completion in completionStream!) {
      setState(() {
        text += completion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Once upon a time',
                style: TextStyle(fontSize: 32, color: Theme.of(context).colorScheme.onPrimary),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(text, style: TextStyle(fontSize: 32, color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handlePress,
        child: const Icon(FontAwesomeIcons.hatWizard),
      ),
    );
  }
}
