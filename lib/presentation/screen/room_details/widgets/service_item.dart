import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';

class ServiceItem extends StatelessWidget {
  final String name;
  final String imagePath;


  const ServiceItem({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colors.stroke,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(
              theme.colors.body,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: theme.typography.textTheme.labelSmall?.copyWith(
              color: theme.colors.body,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}