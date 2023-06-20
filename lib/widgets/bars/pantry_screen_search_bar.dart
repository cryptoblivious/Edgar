import 'package:flutter/material.dart';

import 'package:edgar/widgets/buttons/filter_button.dart';
import 'package:edgar/widgets/buttons/view_options_button.dart';
import 'package:edgar/widgets/boxes/mock_search_box.dart';

class EdgarTopSearchBar extends StatefulWidget {
  const EdgarTopSearchBar({super.key});

  @override
  State<EdgarTopSearchBar> createState() => _EdgarTopSearchBarState();
}

class _EdgarTopSearchBarState extends State<EdgarTopSearchBar> {
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
