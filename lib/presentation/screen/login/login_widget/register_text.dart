import 'package:flutter/material.dart';

import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class RegisterText extends StatelessWidget {
  final VoidCallback onTap;

  const RegisterText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: "Don't have account? ",
          style: AppTypography().textTheme.labelMedium?.copyWith(
            color: AppColors.light.body,
          ),
          children: [
            TextSpan(
              text: 'Register',
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
