import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/design_system/widget/booking_card/booking_card.dart';
import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart' show BookingStatusUiState;

class BookingStatusChip extends StatelessWidget {
  final BookingStatusUiState status;

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
        style: AppTypography.labelXSmall.copyWith(
          color: _getTextColor(theme),
        ),
      ),
    );
  }

  Color _getBackgroundColor(AppTheme theme) {
    switch (status) {
      case BookingStatusUiState.upcoming:
        return theme.colors.yellowVariant;
      case BookingStatusUiState.completed:
        return theme.colors.greenVariant;
      case BookingStatusUiState.canceled:
        return theme.colors.errorVariant;
    }
  }

  Color _getTextColor(AppTheme theme) {
    switch (status) {
      case BookingStatusUiState.upcoming:
        return theme.colors.yellow;
      case BookingStatusUiState.completed:
        return theme.colors.green;
      case BookingStatusUiState.canceled:
        return theme.colors.red;
    }
  }

  String _getStatusText() {
    switch (status) {
      case BookingStatusUiState.upcoming:
        return "Upcoming";
      case BookingStatusUiState.completed:
        return "Completed";
      case BookingStatusUiState.canceled:
        return "Cancelled";
    }
  }
}
