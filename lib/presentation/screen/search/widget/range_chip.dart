import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RangeChip extends StatefulWidget {
  final String label;
  final int value;
  final String image;
  final String unit;

  const RangeChip({
    super.key,
    required this.label,
    required this.value,
    required this.image,
    required this.unit,
  });

  @override
  State<RangeChip> createState() => _RangeChipState();
}

class _RangeChipState extends State<RangeChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      label: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            widget.image,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    widget.value.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Text(widget.unit, style: TextStyle(fontSize: 16, color: Colors.blue)),
        ],
      ),
    );
  }
}
