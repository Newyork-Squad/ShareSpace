import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/splash_screen.dart';
import 'presentation/design_system/theme/app_theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // الحصول على حالة ظهور الـ Onboarding
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(ShareSpaceApp(seenOnboarding: seenOnboarding));
}

class ShareSpaceApp extends StatelessWidget {
  final bool seenOnboarding;
  const ShareSpaceApp({super.key, required this.seenOnboarding});

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
        home: SplashScreen(seenOnboarding: seenOnboarding), // تمرير الحالة للـ SplashScreen
      ),
    );
  }
}
