import 'package:flutter/material.dart';

import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class CreateAccountButton extends StatelessWidget {
  final bool isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const CreateAccountButton({
    super.key,
    required this.isEnabled,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF19C6F9),
        disabledBackgroundColor: AppColors.light.disable,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        text,
        style: AppTypography().textTheme.labelMedium?.copyWith(
          color: AppColors.light.onPrimary,
        ),
      ),
    );
  }
}
