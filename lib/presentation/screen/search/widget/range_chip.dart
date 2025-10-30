import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../design_system/theme/app_theme.dart';

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
    final theme = AppTheme.of(context);
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      label: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            widget.image,
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
                    style: theme.typography.textTheme.labelSmall?.copyWith(
                      color: theme.colors.body,
                    ),
                  ),
                  Text(
                    widget.value.toString(),
                    style:  theme.typography.textTheme.labelLarge?.copyWith(
                      color: theme.colors.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(widget.unit, style: theme.typography.textTheme.labelSmall?.copyWith(
            color: theme.colors.primary,
          )),
        ],
      ),
    );
  }
}
