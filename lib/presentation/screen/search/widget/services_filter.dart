import 'package:flutter/material.dart';

import 'custom_chip.dart';

class ServicesFilter extends StatefulWidget {
  List<String> options;
  List<int> selectedIndices;
  final Function(int) onSelect;

  ServicesFilter({
    super.key,
    required this.options,
    required this.selectedIndices,
    required this.onSelect,
  });

  @override
  State<ServicesFilter> createState() => _ServicesFilterState();
}

class _ServicesFilterState extends State<ServicesFilter> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (var index = 0; index < widget.options.length; index++)
          CustomChip(
            label: widget.options[index],
            icon: iconPathFor(widget.options[index]),
            isSelected: widget.selectedIndices.contains(index),
            onSelect: () {
              widget.onSelect(index);
            },
          ),
      ],
    );
  }


  String iconPathFor(String label) {
    final key = label.trim().toLowerCase();
    const icons = {
      'wifi': 'assets/icons/wifi.svg',
      'whiteboard': 'assets/icons/canvas.svg',
      'call': 'assets/icons/phone.svg',
      'power backup': 'assets/icons/plug.svg',
    };
    return icons[key] ?? '';
  }


}




