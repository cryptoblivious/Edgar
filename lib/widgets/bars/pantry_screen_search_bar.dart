import 'package:flutter/material.dart';

import 'package:edgar/widgets/buttons/filter_button.dart';
import 'package:edgar/widgets/buttons/view_options_button.dart';
import 'package:edgar/widgets/boxes/mock_search_box.dart';

class PantryScreenSearchBar extends StatefulWidget {
  const PantryScreenSearchBar({super.key});

  @override
  State<PantryScreenSearchBar> createState() => _PantryScreenSearchBarState();
}

class _PantryScreenSearchBarState extends State<PantryScreenSearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ViewOptionsButton(),
        MockSearchBox(),
        FilterButton(),
      ],
    );
  }
}
