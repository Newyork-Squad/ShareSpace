import 'package:flutter/material.dart';
import '../../../design_system/widget/custom_chip.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class DurationWidget extends StatefulWidget {
  final List<String>? timeSlots;

  const DurationWidget({super.key, this.timeSlots});

  @override
  State<DurationWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<DurationWidget> {
  String? selectedTime;

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
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
