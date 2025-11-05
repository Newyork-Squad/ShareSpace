import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/screen/room_details/about_room_screen.dart';
import 'package:share_space/presentation/screen/room_details/all_reviews_screen.dart';
import 'package:share_space/presentation/screen/room_details/room_details_screen.dart';

import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/screen/my_account/my_account_screen.dart';

void main() {
  runApp(ShareSpaceApp(appRouter: AppRouter()));
}

class ShareSpaceApp extends StatelessWidget {
  final AppRouter appRouter;

  const ShareSpaceApp({super.key, required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      child: MaterialApp(
        title: 'ShareSpace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.appNavigationBar,  // TODO: change it later
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}