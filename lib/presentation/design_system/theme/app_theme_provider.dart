import 'package:flutter/cupertino.dart';

import '../colors/app_color.dart';
import '../typography/app_typography.dart';
import 'app_theme.dart';

class AppThemeProvider extends StatelessWidget {
  final Widget child;

  const AppThemeProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.light;
    final typography = AppTypography();

    return AppTheme(colors: colors, typography: typography, child: child);
  }
}
