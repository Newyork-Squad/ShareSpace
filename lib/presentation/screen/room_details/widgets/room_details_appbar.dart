import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import '../../../design_system/theme/app_theme.dart';

class RoomDetailsAppbar extends StatelessWidget {
  final String rate;
  final bool isScrolled;

  const RoomDetailsAppbar({
    super.key,
    required this.rate,
    required this.isScrolled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      height: 64,
      padding: const EdgeInsets.only(top: 24,right: 8),
      color: isScrolled?theme.colors.surfaceLow:Colors.transparent, // or any color you prefer
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
              height: 24,
              color: isScrolled?theme.colors.title:  theme.colors.onPrimary,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
            top: 61,
            left: 162,
            right: 162,
            child: Container(
              width: 36,
              height: 22,
              decoration: BoxDecoration(
                color: isScrolled ?theme.colors.yellowVariant : theme.colors.surfaceLow,
                borderRadius: BorderRadius.circular(100),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    color: theme.colors.yellow,
                    width: 12,
                    height: 12,
                  ),

                  Text(

                    rate,
                    style:AppTypography.labelXSmall.copyWith(
                      color: theme.colors.yellow,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/information.svg',
                  width: 24,
                  height: 24,
                  color: isScrolled?theme.colors.title :  theme.colors.onPrimary,
                ),
                onPressed: () {},
              ),


              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/bookmark.svg',
                  width: 24,
                  height: 24,
                  color: isScrolled?theme.colors.title:  theme.colors.onPrimary,
                ),
                onPressed: () {},
              ),
            ],
          ),

        ],
      ),
    );
  }
}