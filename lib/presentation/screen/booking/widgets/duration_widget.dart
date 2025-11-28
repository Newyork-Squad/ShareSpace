import 'package:flutter/material.dart';
import '../../../design_system/widget/custom_chip.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class DurationWidget extends StatefulWidget {
  final List<String>? timeSlots;
  final Function(double) onDurationSelected;

  const DurationWidget({
    super.key,
    this.timeSlots,
    required this.onDurationSelected,
  });

  @override
  State<DurationWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<DurationWidget> {
  String? selectedTime;

  double _parseDuration(String duration) {
    if (duration.endsWith('m')) {
      return double.parse(duration.replaceAll('m', '')) / 60.0;
    } else if (duration.endsWith('h')) {
      return double.parse(duration.replaceAll('h', ''));
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> slots = widget.timeSlots ?? ['30m', '1h', '2h', '3h'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration',
          style: AppTypography().textTheme.titleSmall?.copyWith(
            color: AppColors.light.title,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: slots.map((time) {
            final bool isSelected = selectedTime == time;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomChip(
                label: time,
                isSelected: isSelected,
                size: ChipSize.title,
                labelStyle: AppTypography().textTheme.labelMedium,
                labelColor: isSelected
                    ? AppColors.light.primary
                    : AppColors.light.title,
                onSelect: () {
                  setState(() {
                    selectedTime = time;
                  });
                  widget.onDurationSelected(_parseDuration(time));
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
