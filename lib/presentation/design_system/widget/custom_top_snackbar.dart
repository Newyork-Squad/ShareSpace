import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../design_system/colors/app_color.dart';
import '../../design_system/typography/app_typography.dart';

class CustomTopSnackBar {
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        bool isError = true,
      }) {
    showTopSnackBar(
      Overlay.of(context)!,
      SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isError
                    ? 'assets/images/toast_massage_background_error.png'
                    : 'assets/images/toast_massage_background_success.png',
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                isError ? const Color(0x29AF3333) : const Color(0x2933AF80),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset('assets/icons/close_icon.svg'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(
                      isError
                          ? 'assets/icons/error_icon.svg'
                          : 'assets/icons/success_icon.svg',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography().textTheme.titleMedium?.copyWith(
                            color: AppColors.light.title,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: AppTypography().textTheme.bodySmall?.copyWith(
                            color: AppColors.light.body,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      snackBarPosition: SnackBarPosition.top,
    );
  }
}
