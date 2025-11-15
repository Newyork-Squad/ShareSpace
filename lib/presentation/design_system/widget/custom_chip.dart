import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

import '../typography/app_typography.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final String icon;
  final Color? labelColor;

  const CustomChip({
    super.key,
    required this.label,
    this.icon = '',
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colors.surface,
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
          Text(
            label,
            style: AppTypography.labelXSmall.copyWith(
              color: labelColor ?? theme.colors.body,
            ),
          ),
        ],
      ),
    );
  }
}
