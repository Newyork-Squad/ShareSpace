import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../design_system/theme/app_theme.dart';

class OverAllReviewRate extends StatelessWidget {
  final double rating;
  final int totalReviews;

  const OverAllReviewRate({
    super.key,
    required this.rating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: theme.typography.textTheme.titleMedium?.copyWith(
            color: theme.colors.title,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        RatingBarIndicator(
          rating: 5.0,
          itemCount: 5,
          itemSize: 16,
          unratedColor: theme.colors.surfaceLow,
          direction: Axis.horizontal,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, index) {
            return SvgPicture.asset(
              index <rating-1
                  ? 'assets/icons/filled_star.svg'
                  : 'assets/icons/star_outline.svg',
              color: theme.colors.yellow,
            );
          },
        ),
        const SizedBox(height: 5),
        Text(
          'based on $totalReviews reviews',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.typography.textTheme.labelSmall?.copyWith(
            color: theme.colors.hint,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
