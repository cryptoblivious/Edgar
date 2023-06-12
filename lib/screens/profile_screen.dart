import 'package:flutter/material.dart';
import 'package:edgar/widgets/bars/edgar_bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Text('Profile Screen'));
  }
}
