import 'package:flutter/material.dart';

class LightTheme {
  ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF101010),
    scaffoldBackgroundColor: const Color(0xFFffffff),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        secondaryContainer: Colors.grey.withOpacity(0.2),
        primaryContainer: const Color(0xFFfafafa),
        primary: const Color(0xFFffffff),
        onPrimary: const Color.fromARGB(199, 251, 251, 251),
        secondary: const Color(0xFF101010),
        onSecondary: const Color(0xFF393939),
        error: const Color.fromARGB(255, 255, 63, 63),
        onError: const Color.fromARGB(255, 255, 63, 63),
        background: Color.fromARGB(48, 221, 221, 221),
        onBackground: Color.fromARGB(255, 207, 207, 207),
        surface: const Color(0xFF101010),
        onSurface: const Color(0xFF101010)),
    brightness: Brightness.light,
    shadowColor: Colors.black.withOpacity(0.5),
  );
}
