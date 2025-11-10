import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/injection.dart';
import '../../../domain/usecase/authentication/is_loggedIn_usecase.dart';

// TODO: Implement splash screen properly using native launch screen instead of fixed delay.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final results = await Future.wait<dynamic>([
      SharedPreferences.getInstance(),
      getIt<IsLoggedInUseCase>()(),
    ]);

    final prefs = results[0] as SharedPreferences;
    final isLoggedIn = results[1] as bool;
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (!mounted) return;

    final nextRoute = seenOnboarding
        ? (isLoggedIn ? Routes.appNavigationBar : Routes.loginScreen)
        : Routes.onboardingScreen;

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light.surfaceLow,
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen_icon.png',
          width: 104,
          height: 127,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
