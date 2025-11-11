import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/booking/booking_screen.dart';
import 'package:share_space/presentation/screen/bookingHistory/booking_history_screen.dart';
import 'package:share_space/presentation/screen/chat/chat_screen.dart';
import 'package:share_space/presentation/screen/home/home_screen.dart';
import 'package:share_space/presentation/screen/login/login_screen.dart';
import 'package:share_space/presentation/screen/my_account/my_account_screen.dart';
import 'package:share_space/presentation/screen/onboarding/onboarding_screen.dart';
import 'package:share_space/presentation/screen/room_details/room_details_screen.dart';
import 'package:share_space/presentation/screen/search/search_screen.dart';
import 'package:share_space/presentation/widgets/app_navigation_bar.dart';
import '../screen/create_account/create_account_screen.dart';

class Routes {
  static const String onboardingScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String createAccountScreen = '/createAccountScreen';
  static const String otpVerificationScreen = '/otpVerificationScreen';
  static const String appNavigationBar = '/appNavigationBar';
  static const String homeScreen = '/homeScreen';
  static const String roomDetailsScreen = '/roomDetailsScreen';
  static const String bookingScreen = '/bookingScreen';
  static const String bookingHistoryScreen = '/bookingHistoryScreen';
  static const String searchScreen = '/searchScreen';
  static const String myAccountScreen = '/myAccountScreen';
  static const String chatScreen = '/chatScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    onboardingScreen: (context) => OnboardingScreen(),
    loginScreen: (context) => LoginScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    appNavigationBar: (context) => AppNavigationBar(),
    homeScreen: (context) => HomeScreen(),
    roomDetailsScreen: (context) => RoomDetailsScreen(),
    bookingScreen: (context) => BookingScreen(),
    bookingHistoryScreen: (context) => BookingHistoryScreen(),
    searchScreen: (context) => SearchScreen(),
    myAccountScreen: (context) => MyAccountScreen(),
    chatScreen: (context) => ChatScreen(),
  };
}