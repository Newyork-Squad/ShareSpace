import 'package:flutter/material.dart';
import '../colors/app_color.dart';
import '../typography/app_typography.dart';

class ShareSpaceAppButton extends StatelessWidget {
  final bool isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const ShareSpaceAppButton({
    super.key,
    required this.isEnabled,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 52,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: isEnabled
            ? BoxDecoration(
          gradient: AppColors.light.linear,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColors.light.innerShadow,
              blurRadius: 12,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: AppColors.light.dropShadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        )
            : BoxDecoration(
          color: AppColors.light.disable,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: AppTypography().textTheme.labelMedium?.copyWith(
            color: AppColors.light.onPrimary,
          ),
        ),
      ),
    );
  }
}
