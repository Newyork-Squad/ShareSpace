import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment',
          style: AppTypography().textTheme.titleSmall?.copyWith(
            color: AppColors.light.title,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Select payment method',
          style: AppTypography().textTheme.labelSmall?.copyWith(
            color: AppColors.light.body,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.light.surfaceLow,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.light.stroke, width: 0.5),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/money_icon.svg',
                  width: 24,
                  height: 24,
                ),

                const SizedBox(width: 12),

                Text(
                  'Cash',
                  style: AppTypography().textTheme.labelLarge?.copyWith(
                    color: const Color(0x99070109),
                  ),
                ),

                const Spacer(),

                SvgPicture.asset(
                  'assets/icons/edit_icon.svg',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.light.surfaceLow,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.light.stroke, width: 0.5),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/ticket_star_icon.svg',
                  width: 24,
                  height: 24,
                ),

                const SizedBox(width: 12),

                Text(
                  'Promo Code',
                  style: AppTypography().textTheme.labelLarge?.copyWith(
                    color: const Color(0x99070109),
                  ),
                ),

                const Spacer(),

                SvgPicture.asset(
                  'assets/icons/add_promo_icon.svg',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
