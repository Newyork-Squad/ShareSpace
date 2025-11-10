import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviewer_card.dart';
import '../../design_system/theme/app_theme.dart';

class AllReviewsScreen extends StatelessWidget {
  final List<ReviewModel> reviews;

  const AllReviewsScreen({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.surfaceLow,
      appBar: AppBar(
        backgroundColor: theme.colors.surfaceLow,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            color: theme.colors.title,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'Reviews',
            style: theme.typography.textTheme.titleMedium?.copyWith(
              color: theme.colors.title,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final review = reviews[index];
            return ReviewCard(
              reviewerName: review.reviewerName,
              reviewerImage: review.reviewerImage,
              reviewDate: review.reviewDate,
              rating: review.rating,
              reviewText: review.reviewText,
            );
          },
        ),
      ),
    );
  }
}
