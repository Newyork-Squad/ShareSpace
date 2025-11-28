import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/screen/chat/chat_screen.dart';
import 'package:share_space/presentation/screen/home/home_screen.dart';
import 'package:share_space/presentation/screen/my_account/my_account_screen.dart';
import 'package:share_space/presentation/screen/search/search_screen.dart';

import '../../screen/booking_history/booking_history_screen.dart';
import '../theme/app_theme.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookingHistoryScreen(),
    MyAccountScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: theme.colors.blueVariant,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          selectedIndex: _currentIndex,
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
              selectedIcon: SvgPicture.asset(
                'assets/icons/chatting_filled.svg',
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
