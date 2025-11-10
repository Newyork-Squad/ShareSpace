import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../design_system/theme/app_theme.dart';
import '../../../routes/routes.dart';

class HomeAppBar extends StatefulWidget {
  final String userName;
  final String profileImageUrl;
  final String location;

  const HomeAppBar({
    super.key,
    required this.userName,
    required this.profileImageUrl,
    required this.location,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SliverAppBar(
      collapsedHeight: 167,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: theme.colors.primary,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(widget.profileImageUrl),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: theme.typography.textTheme.labelMedium
                                ?.copyWith(color: theme.colors.onPrimary),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                colorFilter: ColorFilter.mode(
                                  theme.colors.onPrimaryBody,
                                  BlendMode.srcIn,
                                ),
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.location,
                                style: theme.typography.textTheme.labelSmall
                                    ?.copyWith(
                                      color: theme.colors.onPrimaryBody,
                                    ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: theme.colors.onPrimaryBody,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colors.onPrimaryStroke,
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/notification.svg',
                            colorFilter: ColorFilter.mode(
                              theme.colors.onPrimary,
                              BlendMode.srcIn,
                            ),
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: theme.colors.onPrimaryStroke,
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: theme.typography.textTheme.labelMedium
                            ?.copyWith(color: theme.colors.onPrimaryBody),
                        border: InputBorder.none,
                        icon: SvgPicture.asset(
                          'assets/icons/search_filled.svg',
                          colorFilter: ColorFilter.mode(
                            theme.colors.onPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                      ),
                      style: theme.typography.textTheme.labelMedium?.copyWith(
                        color: theme.colors.onPrimaryBody,
                      ),
                    ),
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
