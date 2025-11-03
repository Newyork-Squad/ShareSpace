import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviewer_card.dart';
import '../../design_system/theme/app_theme.dart';

class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final reviews = List.generate(10, (index) => index);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ReviewCard(
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
        ),
      ),
    );
  }
}
