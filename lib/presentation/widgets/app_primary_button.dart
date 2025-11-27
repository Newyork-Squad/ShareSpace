import 'package:flutter/material.dart';

import '../design_system/theme/app_theme.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradientColors,
    this.backgroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.borderRadius = 24,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  final String label;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors =
        gradientColors ?? [theme.colors.primary, theme.colors.primaryVariant];

    final BoxDecoration decoration;
    if (backgroundColor != null) {
      decoration = BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      );
    } else {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: decoration,
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.typography.textTheme.bodyMedium?.copyWith(
            color: textColor ?? theme.colors.onPrimary,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
