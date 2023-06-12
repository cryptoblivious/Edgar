import 'package:flutter/material.dart';

class MockSearchBox extends StatelessWidget {
  const MockSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
            Text(
              'Search',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
