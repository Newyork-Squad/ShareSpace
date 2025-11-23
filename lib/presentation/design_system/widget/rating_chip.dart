import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_theme.dart';
import '../typography/app_typography.dart';

class RatingChip extends StatelessWidget {
  final double rating;

  const RatingChip({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/star.svg", width: 12, height: 12),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: AppTypography.labelXSmall.copyWith(
              color: theme.colors.yellow,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
