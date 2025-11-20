import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_color.dart';
import '../typography/app_typography.dart';

class NotificationCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String date;
  final bool showBottomBorder;

  const NotificationCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.date,
    required this.showBottomBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        border:
            showBottomBorder // <- نستخدم المتغير هنا
            ? Border(
                bottom: BorderSide(color: AppColors.light.stroke, width: 0.5),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, width: 48, height: 48),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTypography().textTheme.labelMedium?.copyWith(
                        color: AppColors.light.title,
                      ),
                    ),
                    Text(
                      date,
                      style: AppTypography.labelXSmall.copyWith(
                        color: AppColors.light.body,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography().textTheme.bodySmall?.copyWith(
                    color: AppColors.light.body,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
