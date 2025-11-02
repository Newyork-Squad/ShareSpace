import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';
import 'custom_chip.dart';

class RatingFilter extends StatefulWidget {
  List<String> options;
  List<int> selectedIndices;
  final Function(int) onSelect;

  RatingFilter({
    super.key,
    required this.options,
    required this.selectedIndices,
    required this.onSelect,
  });

  @override
  State<RatingFilter> createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < widget.options.length; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CustomChip(
              label: widget.options[index],
              icon: (index != 0) ? "assets/icons/star.svg" : "",
              labelColor: theme.colors.yellow,
              isSelected: widget.selectedIndices.contains(index),
              onSelect: () {
                widget.onSelect(index);
              },
            ),
          ),
      ],
    );
  }
}
