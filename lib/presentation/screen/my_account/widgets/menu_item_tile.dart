import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    super.key,
    required this.assetPath,
    required this.iconBackgroundColor,
    required this.title,
    required this.onTap,
    this.trailing,
    this.showChevron = true,
  });

  final String assetPath;
  final Color iconBackgroundColor;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Material(
      color: theme.colors.surfaceLow,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              _buildIcon(theme),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.textTheme.bodyMedium?.copyWith(
                    color: theme.colors.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 24 / 16,
                  ),
                ),
              ),
              if (trailing != null) ...[
                Text(
                  trailing!,
                  style: theme.typography.textTheme.bodySmall?.copyWith(
                    color: theme.colors.hint,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 18 / 12,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (showChevron)
                Icon(Icons.chevron_right, color: theme.colors.hint, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(AppTheme theme) {
    const double size = 44;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: iconBackgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: _buildAsset(),
    );
  }

  Widget _buildAsset() {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(assetPath, width: 24, height: 24);
    }

    return Image.asset(assetPath, width: 24, height: 24, fit: BoxFit.contain);
  }
}
