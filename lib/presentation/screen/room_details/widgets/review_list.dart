import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviewer_card.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: reviews.length < 5 ? reviews.length : 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final review=reviews[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child:  ReviewCard(
              reviewerName: review.reviewerName,
              reviewerImage: review.reviewerImage,
              reviewDate:review.reviewDate,
              rating:review.rating,
              reviewText:review.reviewText
            ),
          );
        },
      ),
    );
  }
}
