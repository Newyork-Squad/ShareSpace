import 'package:flutter/material.dart';
import 'package:share_space/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'resources/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(ShareSpaceApp(appRouter: AppRouter()));
}

class ShareSpaceApp extends StatelessWidget {
  final AppRouter appRouter;
  const ShareSpaceApp({super.key, required this.appRouter});

  Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstOpen = prefs.getBool('isFirstOpen') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isFirstOpen) {
      await prefs.setBool('isFirstOpen', false);
      return Routes.onboardingScreen;
    }

    if (isLoggedIn) {
      return Routes.appNavigationBar;
    }

    return Routes.loginScreen;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(color: Colors.white);
        }
        return AppThemeProvider(
          child: MaterialApp(
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
            ),
            initialRoute: snapshot.data,
            onGenerateRoute: appRouter.generateRoute,
          ),
        );
      },
    );
  }
}
