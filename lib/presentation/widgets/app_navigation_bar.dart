import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design_system/theme/app_theme.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: theme.colors.blueVariant,
        backgroundColor: theme.colors.surfaceLow,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/home.svg'),
            selectedIcon: SvgPicture.asset('assets/icons/home_filled.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/search.svg'),
            selectedIcon: SvgPicture.asset('assets/icons/search_filled.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/file_search.svg'),
            selectedIcon: SvgPicture.asset(
              'assets/icons/file_search_filled.svg',
            ),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/user_circle.svg'),
            selectedIcon: SvgPicture.asset(
              'assets/icons/user_circle_filled.svg',
            ),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/chatting.svg'),
            selectedIcon: SvgPicture.asset('assets/icons/chatting_filled.svg'),
            label: '',
          ),
        ],
      ),
    );
  }
}
