import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/my_account/my_account_screen.dart';

import '../screen/ section/section_screen.dart';
import '../screen/ section/state/section_type_model.dart';
import '../screen/booking/booking_screen.dart';
import '../screen/bookingHistory/booking_history_screen.dart';
import '../screen/chat/chat_screen.dart';
import '../screen/create_account/create_account_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/login/login_screen.dart';
import '../screen/onboarding/onboarding_screen.dart';
import '../screen/room_details/room_details_screen.dart';
import '../screen/search/search_screen.dart';
import '../widgets/app_navigation_bar.dart';
import 'package:share_space/resources/app_strings.dart';
import 'routes.dart';

class AppRouter {
  final Map<String, WidgetBuilder> _routes = {
    Routes.onboardingScreen: (_) => OnboardingScreen(),
    Routes.loginScreen: (_) => LoginScreen(),
    Routes.createAccountScreen: (_) => CreateAccountScreen(),
    Routes.appNavigationBar: (_) => AppNavigationBar(),
    Routes.homeScreen: (_) => HomeScreen(),
    Routes.roomDetailsScreen: (_) => RoomDetailsScreen(),
    Routes.searchScreen: (_) => SearchScreen(),
    Routes.bookingScreen: (_) => BookingScreen(),
    Routes.bookingHistoryScreen: (_) => BookingHistoryScreen(),
    Routes.chatScreen: (_) => ChatScreen(),
    Routes.myAccountScreen: (_) => MyAccountScreen(),
    Routes.sectionScreen:(_)=> SectionScreen()
  };

  Route generateRoute(RouteSettings settings) {

    if (settings.name == Routes.sectionScreen) {
      final type = settings.arguments as SectionType;
      return MaterialPageRoute(
        builder: (_) => SectionScreen(type: type),
        settings: settings,
      );
    }

    final builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            '${AppStrings.noRouteDefined} ${settings.name}',
          ),
        ),
      ),
      settings: settings,
    );
  }
}