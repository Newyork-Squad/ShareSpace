import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../design_system/theme/app_theme.dart';

class RoomDetailsAppbar extends StatelessWidget {
  final String rate;

  const RoomDetailsAppbar({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Stack(
      children: [
        // Back button
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              color: theme.colors.onPrimary,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              print('back');
            },
          ),
        ),

        // Bookmark button
        Positioned(
          top: 40,
          right: 16,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: theme.colors.onPrimary,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              print('bookmark');
            },
          ),
        ),

        // Information button
        Positioned(
          top: 40,
          right: 54,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/information.svg',
              color: theme.colors.onPrimary,
              width: 24,
              height: 24,
            ),
            onPressed: () {
              print('information');
            },
          ),
        ),

        // Rating badge
        Positioned(
          top: 61,
          right: 162,
          child: Container(
            width: 36,
            height: 22,
            decoration: BoxDecoration(
              color: theme.colors.surfaceLow,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: SvgPicture.asset(
                    'assets/icons/star.svg',
                    color: theme.colors.yellow,
                    width: 12,
                    height: 12,
                  ),
                ),
                Text(
                  rate,
                  style: theme.typography.textTheme.labelSmall?.copyWith(
                    color: theme.colors.yellow,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}