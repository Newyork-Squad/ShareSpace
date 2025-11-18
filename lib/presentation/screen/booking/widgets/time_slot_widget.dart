import 'package:flutter/material.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';
import '../../../design_system/widget/custom_chip.dart';

class TimeSlotWidget extends StatefulWidget {
  final List<String>? timeSlots;

  const TimeSlotWidget({super.key, this.timeSlots});

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    final List<String> slots =
        widget.timeSlots ?? ['02:00 PM', '03:00 PM', '03:30 PM', '04:15 PM'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available time to book',
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
