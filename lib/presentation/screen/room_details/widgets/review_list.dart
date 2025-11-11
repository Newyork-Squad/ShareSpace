import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviewer_card.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
