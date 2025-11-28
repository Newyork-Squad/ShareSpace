import 'package:flutter/material.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';
import '../../../design_system/widget/custom_chip.dart';

class TimeSlotWidget extends StatefulWidget {
  final List<String>? timeSlots;
  final Function(String) onStartTimeSelected;
  final Function(String) onEndTimeSelected;

  const TimeSlotWidget({
    super.key,
    this.timeSlots,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
  });

  @override
  State<TimeSlotWidget> createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  String? selectedStartTime;
  String? selectedEndTime;

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
            final bool isSelected = selectedStartTime == time || selectedEndTime == time;
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
                    if (selectedStartTime == null) {
                      selectedStartTime = time;
                      widget.onStartTimeSelected(time);
                    } else if (selectedEndTime == null) {
                      selectedEndTime = time;
                      widget.onEndTimeSelected(time);
                    } else {
                      selectedStartTime = time;
                      selectedEndTime = null;
                      widget.onStartTimeSelected(time);
                    }
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
