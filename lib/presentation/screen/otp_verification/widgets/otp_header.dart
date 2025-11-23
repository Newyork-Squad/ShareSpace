import 'package:flutter/material.dart';
import '../../../design_system/theme/app_theme.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Confirm your account',
            style: theme.typography.textTheme.titleMedium?.copyWith(
              color: theme.colors.title,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Enter 6-digit code that sent to your phone number',
            style: theme.typography.textTheme.bodyMedium?.copyWith(
              color: theme.colors.body,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


