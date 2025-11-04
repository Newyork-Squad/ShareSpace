import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/screen/room_details/about_room_screen.dart';
import 'package:share_space/presentation/screen/room_details/all_reviews_screen.dart';
import 'package:share_space/presentation/screen/room_details/room_details_screen.dart';

import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      colors: AppColors.light,
      typography: AppTypography(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.onboardingScreen,
      onGenerateRoute: appRouter.generateRoute,
    ));
  }
}