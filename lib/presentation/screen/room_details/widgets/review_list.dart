import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviewer_card.dart';
import '../../../design_system/theme/app_theme.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = List.generate(10, (index) => index);

    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: reviews.length < 4 ? reviews.length : 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: const ReviewCard(
              reviewerName: 'Hamsa Ali Hussain',
              reviewerImage: 'assets/images/owner.png',
              reviewDate: '12-04-2024',
              rating: 5,
              reviewText:
                  'Cozy and quiet workspace! The WiFi was fast, and the chairs were super comfy. Perfect for long study sessions.',
            ),
          );
        },
      ),
    );
  }
}
