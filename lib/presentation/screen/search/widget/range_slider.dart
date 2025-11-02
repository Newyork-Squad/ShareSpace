import 'package:flutter/material.dart';

import '../../../design_system/theme/app_theme.dart';

class RangeSliderWidget extends StatefulWidget {
  final RangeValues maxRange;
  RangeValues? currentRange;
  final String currency;
  final Function(RangeValues) onChange;

  RangeSliderWidget({
    super.key,
    required this.maxRange,
    required this.currency,
    this.currentRange,
    required this.onChange,
  });

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.maxRange.start.round()} ${widget.currency}',
              style: theme.typography.textTheme.labelSmall?.copyWith(
                color: theme.colors.body,
              ),
            ),
            Text(
              '${widget.maxRange.end.round()} ${widget.currency}',
              style: theme.typography.textTheme.labelSmall?.copyWith(
                color: theme.colors.body,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: theme.colors.secondary,
            thumbColor: theme.colors.secondary,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
            overlappingShapeStrokeColor: theme.colors.stroke,
            inactiveTrackColor: theme.colors.surface,
            trackHeight: 8,
            overlayColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 0),
          ),
          child: RangeSlider(
            values: widget.currentRange ?? widget.maxRange,
            min: widget.maxRange.start,
            max: widget.maxRange.end,
            onChanged: widget.onChange,
          ),
        ),
      ],
    );
  }
}
