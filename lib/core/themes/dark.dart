import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
        secondaryContainer: Colors.black26,
        primaryContainer: Color(0xFF1f222a),
        brightness: Brightness.dark,
        primary: Color(0xFF181a20),
        onPrimary: Color(0xFF1f222a),
        secondary: Color(0xFFfafafa),
        onSecondary: Color(0xFF393939),
        error: Color.fromARGB(255, 255, 137, 137),
        onError: Color.fromARGB(255, 255, 137, 137),
        background: Color(0xFF201c24),
        onBackground: Color(0xFF201c24),
        surface: Color(0xFF201c24),
        onSurface: Color(0xFF201c24)),
    shadowColor: Colors.white10,
    scaffoldBackgroundColor: const Color(0xFF181a20),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle:
          TextStyle(color: Color(0xFF9e9e9e), fontWeight: FontWeight.w100),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 2,
          color: Color(0xFFe7e7e7),
        ),
      ),
    ),
  );
}