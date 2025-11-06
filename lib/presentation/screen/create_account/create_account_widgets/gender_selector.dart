import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';

class GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: AppTypography().textTheme.titleSmall?.copyWith(
            color: AppColors.light.body,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildGenderButton(
                gender: "Male",
                iconPath: "assets/icons/male_icon.svg",
                selectedIconPath: "assets/icons/male_selected_icon.svg",
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildGenderButton(
                gender: "Female",
                iconPath: "assets/icons/female_icon.svg",
                selectedIconPath: "assets/icons/female_selected_icon.svg",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton({
    required String gender,
    required String iconPath,
    required String selectedIconPath,
  }) {
    final bool isSelected = gender == selectedGender;

    return GestureDetector(
      onTap: () => onGenderSelected(gender),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.light.primary : AppColors.light.stroke,
            width: isSelected ? 1.5 : 0.5,
          ),
          borderRadius: BorderRadius.circular(100),
          color: isSelected
              ? AppColors.light.blueVariant
              : AppColors.light.surfaceLow,
          boxShadow: isSelected
              ? [
            const BoxShadow(
              color: Color(0x3D84E2FE),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? selectedIconPath : iconPath,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColors.light.primary
                    : AppColors.light.body,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              gender,
              style: AppTypography().textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppColors.light.primary
                    : AppColors.light.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
