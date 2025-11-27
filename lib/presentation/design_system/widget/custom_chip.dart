import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_color.dart';
import '../theme/app_theme.dart';
import '../typography/app_typography.dart';

enum ChipSize { body, title }

class CustomChip extends StatelessWidget {
  final String label;
  final String icon;
  final Color labelColor;
  final bool isSelected;
  final VoidCallback? onSelect;
  final ChipSize size;
  final TextStyle? labelStyle;

  CustomChip({
    super.key,
    required this.label,
    this.icon = '',
    Color? labelColor,
    this.isSelected = false,
    this.onSelect,
    this.size = ChipSize.body,
    this.labelStyle,
  }) : labelColor = labelColor ?? AppColors.light.title;

  TextStyle _resolveTextStyle() {
    if (labelStyle != null) return labelStyle!;

    switch (size) {
      case ChipSize.title:
        return AppTypography.labelXSmall.copyWith(fontWeight: FontWeight.w600);
      case ChipSize.body:
      default:
        return AppTypography.labelXSmall;
    }
  }

  EdgeInsets _resolvePadding() {
    switch (size) {
      case ChipSize.title:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
      case ChipSize.body:
      default:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: _resolvePadding(),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.blueVariant : theme.colors.surface,
          border: Border.all(color: theme.colors.stroke, width: 0.5),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon.isNotEmpty) ...[
              SvgPicture.asset(icon, width: 12, height: 12),
              const SizedBox(width: 2),
            ],
            Text(label, style: _resolveTextStyle().copyWith(color: labelColor)),
          ],
        ),
      ),
    );
  }
}
