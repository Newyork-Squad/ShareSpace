import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
    required this.title,
    required this.name,
    required this.email,
    this.bio,
    this.imageUrl,
  });

  final String title;
  final String name;
  final String email;
  final String? bio;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      width: double.infinity,
      color: theme.colors.surfaceLow,
      child: Stack(
        children: [
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/rectangle.png',
              height: 280,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: theme.typography.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colors.title,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildProfileImage(theme),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: theme.typography.textTheme.bodySmall?.copyWith(
                    color: theme.colors.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 22 / 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: theme.typography.textTheme.bodySmall?.copyWith(
                    color: theme.colors.body,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 18 / 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (bio != null) ...[
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        bio!,
                        style: theme.typography.textTheme.bodySmall?.copyWith(
                          color: theme.colors.body,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(AppTheme theme) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 104,
          height: 104,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colors.primary.withValues(alpha: 0.82),
                  theme.colors.primaryVariant,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderAvatar(theme);
                      },
                    )
                  : _buildPlaceholderAvatar(theme),
            ),
          ),
        ),
        Positioned(
          bottom: -16,
          child: SvgPicture.asset(
            'assets/images/Frame 2147223710.svg',
            width: 44,
            height: 44,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderAvatar(AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: theme.typography.textTheme.labelMedium?.copyWith(
            color: theme.colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
