import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String reviewerImage;
  final String reviewDate;
  final int rating;
  final String reviewText;

  const ReviewCard({
    super.key,
    required this.reviewerName,
    required this.reviewerImage,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colors.stroke, width: 0.5),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  reviewerImage,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: theme.typography.textTheme.labelSmall?.copyWith(
                        color: theme.colors.title,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/calender.svg',
                          width: 12,
                          height: 12,
                          color: theme.colors.body,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          reviewDate,
                          style: theme.typography.textTheme.labelSmall
                              ?.copyWith(
                                color: theme.colors.body,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: 36,
                height: 22,
                decoration: BoxDecoration(
                  color: theme.colors.surfaceLow,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: theme.colors.stroke, width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      width: 12,
                      height: 12,
                      color: theme.colors.yellow,
                    ),
                    const SizedBox(width: 1),
                    Text(
                      rating.toString(),
                      style: theme.typography.textTheme.labelSmall?.copyWith(
                        color: theme.colors.yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            reviewText,
            style: theme.typography.textTheme.bodySmall?.copyWith(
              color: theme.colors.body,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
