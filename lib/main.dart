import 'package:flutter/material.dart';

import 'presentation/design_system/theme/app_theme_provider.dart';
import 'presentation/screen/my_account/my_account_screen.dart';

void main() {
  runApp(const ShareSpaceApp());
}

class ShareSpaceApp extends StatelessWidget {
  const ShareSpaceApp({super.key});

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
        home: const MyAccountScreen(),
      ),
    );
  }
}
