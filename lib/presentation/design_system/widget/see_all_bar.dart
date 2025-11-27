import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import '../typography/app_typography.dart';

class SeeAllBar extends StatelessWidget {
  final String title;
  final VoidCallback? onAllTap;

  const SeeAllBar({Key? key, required this.title, required this.onAllTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.light.title;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography().textTheme.titleSmall?.copyWith(
            color: textColor,
          ),
        ),

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onAllTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "All",
                  style: AppTypography().textTheme.labelSmall?.copyWith(
                    color: textColor,
                  ),
                ),
              ),

              const SizedBox(width: 7),

              Center(
                child: SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: 5,
                  height: 9,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
