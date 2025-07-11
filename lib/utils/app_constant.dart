import 'package:flutter/material.dart';

class AppConstants {
  // Dynamic background color based on theme
  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  // Dynamic app bar color
  static Color appBarColor(BuildContext context) =>
      Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).primaryColor;

  // Glass effect gradient (static, can be reused)
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(100, 255, 255, 255), // Transparent white
      Color.fromARGB(60, 255, 255, 255),
    ],
  );
}
