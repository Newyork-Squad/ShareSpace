import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/booking/booking_screen.dart';
import 'package:share_space/presentation/screen/bookingHistory/booking_history_screen.dart';
import 'package:share_space/presentation/screen/chat/chat_screen.dart';
import 'package:share_space/presentation/screen/createAccount/create_account_screen.dart';
import 'package:share_space/presentation/screen/home/home_screen.dart';
import 'package:share_space/presentation/screen/login/login_screen.dart';
import 'package:share_space/presentation/screen/onboarding/onboarding_screen.dart';
import 'package:share_space/presentation/screen/profile/profile_screen.dart';
import 'package:share_space/presentation/screen/room_details/room_details_screen.dart';
import 'package:share_space/presentation/screen/search/search_screen.dart';
import 'package:share_space/presentation/screen/splash/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String onboardingScreen = '/onboardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String createAccountScreen = '/createAccountScreen';
  static const String homeScreen = '/homeScreen';
  static const String roomDetailsScreen = '/roomDetailsScreen';
  static const String bookingScreen = '/bookingScreen';
  static const String bookingHistoryScreen = '/bookingHistoryScreen';
  static const String searchScreen = '/searchScreen';
  static const String profileScreen = '/profileScreen';
  static const String chatScreen = '/chatScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => SplashScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    loginScreen: (context) => LoginScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    homeScreen: (context) => HomeScreen(),
    roomDetailsScreen: (context) => RoomDetailsScreen(),
    bookingScreen: (context) => BookingScreen(),
    bookingHistoryScreen: (context) => BookingHistoryScreen(),
    searchScreen: (context) => SearchScreen(),
    profileScreen: (context) => ProfileScreen(),
    chatScreen: (context) => ChatScreen(),
  };
}