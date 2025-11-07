import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_space/presentation/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  final bool seenOnboarding;
  const SplashScreen({super.key, required this.seenOnboarding});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      if (widget.seenOnboarding) {
        // لو شوفت الـ Onboarding قبل كده
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      } else {
        // لو أول مرة
        Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
      }
    });
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
