import 'package:flutter/material.dart';

import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';

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
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
