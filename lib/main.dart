import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/screen/room_details/about_room_screen.dart';
import 'package:share_space/presentation/screen/room_details/all_reviews_screen.dart';
import 'package:share_space/presentation/screen/room_details/room_details_screen.dart';
import 'package:share_space/presentation/screen/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      colors: AppColors.light,
      typography: AppTypography(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RoomDetailsScreen(),
    ));
  }
}
