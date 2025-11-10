import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const light = AppColorScheme(
    primary: Color(0xFF39BADF),
    primaryVariant: Color(0xFF14A2CC),
    secondary: Color(0xFFFF7C38),
    secondaryVariant: Color(0xFFFFF2EB),
    blueAccent: Color(0xFF18A3FF),
    blueVariant: Color(0xFFEBF7FF),
    surfaceLow: Color(0xFFFFFFFF),
    surface: Color(0xFFF9FBFB),
    title: Color(0xDE1F1F1F),
    body: Color(0x991F1F1F),
    hint: Color(0x611F1F1F),
    stroke: Color(0x141F1F1F),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryBody: Color(0xA8FFFFFF),
    onPrimaryStroke: Color(0x29E8EBED),
    disable: Color(0xFFE8EBED),
    yellow: Color(0xFFF5A623),
    yellowVariant: Color(0xFFFEF3E1),
    red: Color(0xFFF4505C),
    errorVariant: Color(0xFFFFEEEF),
    green: Color(0xFF51AC46),
    greenVariant: Color(0xFFF1F9F1),
  );
}

class AppColorScheme {
  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color secondaryVariant;
  final Color blueAccent;
  final Color blueVariant;
  final Color surfaceLow;
  final Color surface;
  final Color title;
  final Color body;
  final Color hint;
  final Color stroke;
  final Color onPrimary;
  final Color onPrimaryBody;
  final Color onPrimaryStroke;
  final Color disable;
  final Color yellow;
  final Color yellowVariant;
  final Color red;
  final Color errorVariant;
  final Color green;
  final Color greenVariant;

  const AppColorScheme({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.secondaryVariant,
    required this.blueAccent,
    required this.blueVariant,
    required this.surfaceLow,
    required this.surface,
    required this.title,
    required this.body,
    required this.hint,
    required this.stroke,
    required this.onPrimary,
    required this.onPrimaryBody,
    required this.onPrimaryStroke,
    required this.disable,
    required this.yellow,
    required this.yellowVariant,
    required this.red,
    required this.errorVariant,
    required this.green,
    required this.greenVariant,
  });
}
