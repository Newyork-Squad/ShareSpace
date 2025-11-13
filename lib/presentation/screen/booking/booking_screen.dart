import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/booking/widgets/confirm_booking_bottom_sheet.dart';

import '../../design_system/theme/app_theme.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              backgroundColor: theme.colors.surfaceLow,
              isScrollControlled: true,
              builder: (_) => ConfirmBookingBottomSheet(
                roomName: 'Modern study room',
                price: '12,000 IQD',
                date: '27 Jun 2025',
                time: '03:00 PM',
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );  }
}
