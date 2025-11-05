import 'package:flutter/material.dart';

import '../screen/booking/booking_screen.dart';
import '../screen/bookingHistory/booking_history_screen.dart';
import '../screen/chat/chat_screen.dart';
import '../screen/createAccount/create_account_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/login/login_screen.dart';
import '../screen/onboarding/onboarding_screen.dart';
import '../screen/room_details/room_details_screen.dart';
import '../screen/search/search_screen.dart';
import '../screen/splash/splash_screen.dart';
import '../widgets/app_navigation_bar.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.createAccountScreen:
        return MaterialPageRoute(builder: (_) => CreateAccountScreen());
      case Routes.appNavigationBar:
        return MaterialPageRoute(builder: (_) => AppNavigationBar());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.roomDetailsScreen:
        return MaterialPageRoute(builder: (_) => RoomDetailsScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Routes.bookingScreen:
        return MaterialPageRoute(builder: (_) => BookingScreen());
      case Routes.bookingHistoryScreen:
        return MaterialPageRoute(builder: (_) => BookingHistoryScreen());
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => ChatScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}