import 'package:flutter/material.dart';
import 'package:share_space/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(ShareSpaceApp(appRouter: AppRouter()));
}

class ShareSpaceApp extends StatelessWidget {
  final AppRouter appRouter;
  const ShareSpaceApp({super.key, required this.appRouter});

  Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstOpen = prefs.getBool('isFirstOpen') ?? true;

    if (isFirstOpen) {
      prefs.setBool('isFirstOpen', false);
      return Routes.onboardingScreen;
    } else {
      return Routes.loginScreen;
    }
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
            title: 'ShareSpace',
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
