import 'package:flutter/material.dart';

import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

void main() {
  runApp(ShareSpaceApp(appRouter: AppRouter()));
  // الحصول على حالة ظهور الـ Onboarding
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(ShareSpaceApp(seenOnboarding: seenOnboarding));
}

class ShareSpaceApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool seenOnboarding;
  const ShareSpaceApp({super.key, required this.seenOnboarding, required this.appRouter});

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
