import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 44, 44, 44), // any surface above background
    background: Color(0xFF141414), // background color
    primary: Color(0xFFF3CA92), // primary buttons etc
    secondary: Color(0xFFAE9370), // dulled primary
    tertiary: Color(0xFF92F396), // secondary buttons
    onSurface: Color(0xFF787878), // On Surface title
    onBackground: Color(0xFFFFFFFF), // on Background title
    onPrimary: Color(0xFF141414), // Text on primary
    onSecondary: Color(0xFF141414), // text on secondary
    onTertiary: Color(0xFF141414), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 44, 44, 44), // any surface above background
    background: Color(0xFF141414), // background color
    primary: Color(0xFFF3CA92), // primary buttons etc
    secondary: Color(0xFFAE9370), // dulled primary
    tertiary: Color(0xFF92F396), // secondary buttons
    onSurface: Color(0xFF787878), // On Surface title
    onBackground: Color(0xFFFFFFFF), // on Background title
    onPrimary: Color(0xFF141414), // Text on primary
    onSecondary: Color(0xFF141414), // text on secondary
    onTertiary: Color(0xFF141414), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        ),
);