import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/screen/room_details/all_reviews_screen.dart';

import '../../../design_system/theme/app_theme.dart';
import '../state/about_room/about_room_state.dart';

class ReviewsHeader extends StatelessWidget {
  final int numberOfReviews;
  final List<ReviewModel> reviews;

  const ReviewsHeader({super.key, required this.numberOfReviews, required this.reviews});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Reviews ($numberOfReviews)',
          style: theme.typography.textTheme.titleSmall?.copyWith(
            color: theme.colors.title,
            fontWeight: FontWeight.w600,
          ),
        ),

        InkWell(
          onTap: () {Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AllReviewsScreen( reviews:reviews),
            ),
          );},
          child: Row(
            children: [
              Text(
                'All',
                style: theme.typography.textTheme.labelSmall?.copyWith(
                  color: theme.colors.title,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                color: theme.colors.title,
                width: 12,
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}