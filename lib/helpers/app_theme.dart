import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.brown,
    colorScheme: ColorScheme.light(
      primary: Colors.brown,
      secondary: Colors.brown.shade900,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
    // Customize other theme properties as needed
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black12,
    colorScheme: const ColorScheme.dark(
      primary: Colors.black12,
      secondary: Colors.black45,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.grey),
      bodyMedium: TextStyle(color: Colors.grey),
      titleLarge: TextStyle(color: Colors.grey),
    ),
    // Customize other theme properties as needed
  );
}

// class AppColor {
//  static const Color lightPrimaryColor = Color(0xFF4CAF50);
// }
