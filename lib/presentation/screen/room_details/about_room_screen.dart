import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/about_room/about_room_state.dart';
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

    return BlocProvider(
      create: (_) => AboutRoomCubit()..loadRoomDetails(),
      child: BlocBuilder<AboutRoomCubit, AboutRoomState>(
        builder: (context, state) {
          final theme = AppTheme.of(context);

          if (state is AboutRoomLoading || state is AboutRoomInitial) {
            return Center(
              child: CircularProgressIndicator(color: theme.colors.yellow),
            );
          }

          if (state is AboutRoomError) {
            return Center(
              child: Text(
                state.message,
                style: theme.typography.textTheme.bodyMedium?.copyWith(
                  color: theme.colors.title,
                ),
              ),
            );
          }

          if (state is AboutRoomLoaded) {
            final data = state.data;
            return Scaffold(
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
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colors.stroke,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                children: const [
                                  ReviewsIndicator(
                                    rateNumber: '5',
                                    rateValue: 0.8,
                                  ),
                                  ReviewsIndicator(
                                    rateNumber: '4',
                                    rateValue: 0.6,
                                  ),
                                  ReviewsIndicator(
                                    rateNumber: '3',
                                    rateValue: 0.4,
                                  ),
                                  ReviewsIndicator(
                                    rateNumber: '2',
                                    rateValue: 0.2,
                                  ),
                                  ReviewsIndicator(
                                    rateNumber: '1',
                                    rateValue: 0.1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 4,
                              child: OverAllReviewRate(
                                rating: 4.0,
                                totalReviews: data.totalReviews,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ReviewsHeader(
                        numberOfReviews: data.totalReviews,
                        reviews: data.reviews,
                      ),
                      const SizedBox(height: 12),
                      ReviewsList(reviews: data.reviews),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();

        },
      ),
    );
  }
}
