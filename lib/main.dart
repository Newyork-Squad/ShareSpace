import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      colors: AppColors.light,
      typography: AppTypography(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
