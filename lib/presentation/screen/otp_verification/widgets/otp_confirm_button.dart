import 'package:flutter/material.dart';
import '../../../design_system/theme/app_theme.dart';

class OtpConfirmButton extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const OtpConfirmButton({
    super.key,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? theme.colors.primary
              : theme.colors.disable,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBackgroundColor: theme.colors.disable,
          disabledForegroundColor: theme.colors.hint,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colors.surfaceLow,
                  ),
                ),
              )
            : Text(
                'Confirm',
                style: theme.typography.textTheme.labelLarge?.copyWith(
                  color: isEnabled
                      ? theme.colors.onPrimary
                      : theme.colors.hint,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}


