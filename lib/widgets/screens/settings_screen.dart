import 'package:flutter/material.dart';
import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text('Settings Screen'));
  }
}
