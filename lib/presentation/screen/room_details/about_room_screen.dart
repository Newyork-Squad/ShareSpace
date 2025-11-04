import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/screen/room_details/widgets/overall_review_rate.dart';
import 'package:share_space/presentation/screen/room_details/widgets/review_list.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviews_header.dart';
import 'package:share_space/presentation/screen/room_details/widgets/reviews_indecator.dart';

import '../../design_system/theme/app_theme.dart';

class AboutRoomScreen extends StatelessWidget {
  const AboutRoomScreen({super.key});

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
            onPressed: () {
              print(' on back click');
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              color: theme.colors.title,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'About room',
              style: theme.typography.textTheme.titleMedium?.copyWith(
                color: theme.colors.title,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colors.stroke, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            ReviewsIndicator(rateNumber: '5', rateValue: 0.8),
                            ReviewsIndicator(rateNumber: '4', rateValue: 0.6),
                            ReviewsIndicator(rateNumber: '3', rateValue: 0.4),
                            ReviewsIndicator(rateNumber: '2', rateValue: 0.2),
                            ReviewsIndicator(rateNumber: '1', rateValue: 0.1),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(flex: 4, child: OverAllReviewRate(rating: 4.0,totalReviews: 122,)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ReviewsHeader(),
                const SizedBox(height: 12),
                const ReviewsList(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
