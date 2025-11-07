import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';
import '../../../widgets/app_primary_button.dart';

class LogoutConfirmationSheet extends StatelessWidget {
  const LogoutConfirmationSheet({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: theme.colors.surfaceLow,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SheetHeader(title: 'Logout'),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colors.errorVariant,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/logout-05.svg',
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(
                          theme.colors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Logging out means saying goodbye to your workspaces, Are you sure to continue?',
                      style: theme.typography.textTheme.bodySmall?.copyWith(
                        color: theme.colors.body,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 22 / 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: 'Logout',
                    onPressed: onConfirm,
                    backgroundColor: const Color(0xFFFFEEEF),
                    textColor: const Color(0xFFF4505C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.typography.textTheme.bodyMedium?.copyWith(
              color: theme.colors.title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 24 / 18,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).maybePop(),
          child: Icon(Icons.close, color: theme.colors.hint, size: 20),
        ),
      ],
    );
  }
}
