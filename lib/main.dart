import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share_space/di/injection.dart';

import 'domain/usecase/User/is_first_open_use_case.dart';
import 'domain/usecase/User/set_first_open_completed_use_case.dart';
import 'domain/usecase/authentication/is_loggedIn_usecase.dart';
import 'firebase_options.dart';
import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/routes.dart';
import 'resources/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencies();
  runApp(ShareSpaceApp(appRouter: AppRouter()));
}

class ShareSpaceApp extends StatelessWidget {
  final AppRouter appRouter;

  const ShareSpaceApp({super.key, required this.appRouter});

  Future<String> _getInitialRoute() async {
    final isFirstOpen = await getIt<IsFirstOpenUseCase>()();

    if (isFirstOpen) {
      await getIt<SetFirstOpenCompletedUseCase>()();
      return Routes.onboardingScreen;
    }

    final isLoggedIn = await getIt<IsLoggedInUseCase>()();

    return isLoggedIn ? Routes.appNavigationBar : Routes.loginScreen;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
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
