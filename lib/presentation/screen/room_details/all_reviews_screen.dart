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

    return Padding(
      padding: EdgeInsets.only(left: 16,right: 16,top: 12),
      child: Scaffold(
        backgroundColor: theme.colors.surfaceLow,
        appBar: AppBar(
          backgroundColor: theme.colors.surfaceLow,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {},
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
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: ListView.builder(
            itemCount: reviews.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ReviewCard(
                  reviewerName: review.reviewerName,
                  reviewerImage: review.reviewerImage,
                  reviewDate: review.reviewDate,
                  rating: review.rating,
                  reviewText: review.reviewText,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
