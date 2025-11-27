import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../design_system/colors/app_color.dart';
import '../../design_system/typography/app_typography.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String location;
  final String svgIconPath;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const AddressCard({
    super.key,
    required this.title,
    required this.location,
    required this.svgIconPath,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.light.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0x14070109), width: 0.5),
      ),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(svgIconPath, width: 40, height: 40),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography().textTheme.titleSmall?.copyWith(
                        color: AppColors.light.title,
                      ),
                    ),
                    Text(
                      location,
                      style: AppTypography().textTheme.bodySmall?.copyWith(
                        color: AppColors.light.body,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.light.redVariant,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: AppColors.light.stroke,
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Delete",
                        style: AppTypography().textTheme.labelSmall?.copyWith(
                          color: AppColors.light.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.light.blueVariant,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: AppColors.light.stroke,
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Edit location",
                        style: AppTypography().textTheme.labelSmall?.copyWith(
                          color: AppColors.light.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
