import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_color.dart';
import '../typography/app_typography.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? rightIcon;
  final VoidCallback? onBackTap;
  final VoidCallback? onRightIconTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.rightIcon,
    this.onBackTap,
    this.onRightIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onBackTap ?? () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/icons/arrow_left.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(AppColors.light.title, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTypography().textTheme.titleMedium?.copyWith(
                color: AppColors.light.title,
              ),
            ),
          ],
        ),

        rightIcon != null
            ? GestureDetector(
                onTap: onRightIconTap,
                child: SvgPicture.asset(rightIcon!, width: 24, height: 24),
              )
            : const SizedBox(),
      ],
    );
  }
}
