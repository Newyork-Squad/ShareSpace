import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/my_account/my_account_screen.dart';

import '../screen/booking/book_room_screen.dart';
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
    Routes.bookRoomScreen: (_) => BookRoomScreen()
  };

  Route generateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
      settings: settings,
    );
  }
}