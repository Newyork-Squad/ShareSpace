import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/widget/booking_card/booking_card.dart';

class BookingStatusChip extends StatelessWidget {
  final BookingStatus status;

  const BookingStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        _getStatusText(),
        style: theme.typography.textTheme.labelMedium?.copyWith(
          color: _getTextColor(theme),
        ),
      ),
    );
  }

  Color _getBackgroundColor(AppTheme theme) {
    switch (status) {
      case BookingStatus.upcoming:
        return theme.colors.yellowVariant.withOpacity(0.1);
      case BookingStatus.completed:
        return theme.colors.greenVariant.withOpacity(0.1);
      case BookingStatus.canceled:
        return theme.colors.errorVariant.withOpacity(0.1);
    }
  }

  Color _getTextColor(AppTheme theme) {
    switch (status) {
      case BookingStatus.upcoming:
        return theme.colors.yellowVariant;
      case BookingStatus.completed:
        return theme.colors.greenVariant;
      case BookingStatus.canceled:
        return theme.colors.errorVariant;
    }
  }

  String _getStatusText() {
    switch (status) {
      case BookingStatus.upcoming:
        return "Upcoming";
      case BookingStatus.completed:
        return "Completed";
      case BookingStatus.canceled:
        return "Canceled";
    }
  }
}
