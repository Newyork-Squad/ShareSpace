import 'package:flutter/material.dart';

import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';
import 'package:share_space/resources/app_strings.dart';

class RegisterText extends StatelessWidget {
  final VoidCallback onTap;

  const RegisterText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: AppStrings.loginRegisterPrompt,
          style: AppTypography().textTheme.labelMedium?.copyWith(
            color: AppColors.light.body,
          ),
          children: [
            TextSpan(
              text: AppStrings.actionRegister,
              style: AppTypography().textTheme.labelMedium?.copyWith(
                color: AppColors.light.primary,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
