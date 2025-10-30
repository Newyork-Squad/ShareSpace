import 'package:flutter/material.dart';

import 'custom_chip.dart';

class RatingFilter extends StatefulWidget {
  List<String> options;
  List<int> selectedIndex;
  final Function(int) onSelect;

  RatingFilter({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  State<RatingFilter> createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < widget.options.length; index++)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomChip(
              label: widget.options[index],
              icon: (index != 0) ? "assets/icons/star.svg" : "",
              isSelected: widget.selectedIndex.contains(index),
              onSelect: () {
                widget.onSelect(index);
              },
            ),
          ),
      ],
    );
  }
}
