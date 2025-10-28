import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.maxRange.start.round()} ${widget.currency}'),
            Text('${widget.maxRange.end.round()} ${widget.currency}'),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFFFF7C38),
            thumbColor: Color(0xFFFF7C38),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
            overlappingShapeStrokeColor: Colors.black,
            inactiveTrackColor: Color(0xFFF9FBFB).withValues(alpha: 0.8),
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
