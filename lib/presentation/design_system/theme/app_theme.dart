import 'package:flutter/cupertino.dart';

import '../colors/app_color.dart';
import '../typography/app_typography.dart';

class AppTheme extends InheritedWidget {
  
  final AppColorScheme colors;
  final AppTypography typography;

  const AppTheme({
    super.key,
    required this.colors,
    required this.typography,
    required super.child,
  });

  static AppTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return colors != oldWidget.colors || typography != oldWidget.typography;
  }
}
