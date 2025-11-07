import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'onboarding/onboarding_screen.dart';
import 'login/login_screen.dart'; // تأكد من المسار الصحيح للـ LoginScreen
import 'package:shared_preferences/shared_preferences.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        // لو أول مرة
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
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
