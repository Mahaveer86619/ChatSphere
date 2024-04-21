import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color(0xFF9AC8CD), // any surface above background
    background: Color(0xFFE1F7F5), // background color
    primary: Color(0xFF1E0342), // primary buttons etc
    secondary: Color(0xFF0E46A3), // dulled primary
    tertiary: Color(0xFF92F396), // secondary buttons
    onSurface: Color(0xFF1F1717), // On Surface title
    onBackground: Color(0xFF1F1717), // on Background title
    onPrimary: Color(0xFFE1F7F5), // Text on primary
    onSecondary: Color(0xFFE1F7F5), // text on secondary
    onTertiary: Color(0xFFFFFFFF), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Color(0xFF1E0342),
    unselectedItemColor: Color(0xFFD2B0FF),
    selectedIconTheme: IconThemeData(color: Color(0xFF1E0342)),
    unselectedIconTheme: IconThemeData(color: Color(0xFFD2B0FF)),
    selectedLabelStyle: TextStyle(color: Color(0xFF1E0342)),
    unselectedLabelStyle: TextStyle(color: Color(0xFFD2B0FF)),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF2A2929), // any surface above background
    background: Color(0xFF1E1E1E), // background color
    primary: Color(0xFFF3CA92), // primary buttons etc
    secondary: Color(0xFFAE9370), // dulled primary
    tertiary: Color(0xFF92F396), // secondary buttons
    onSurface: Color(0xFFD9D9D9), // On Surface title
    onBackground: Color(0xFFF1F1F1), // on Background title
    onPrimary: Color(0xFF141414), // Text on primary
    onSecondary: Color(0xFF141414), // text on secondary
    onTertiary: Color(0xFF141414), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    // backgroundColor: Color(value),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Color(0xFF1E0342),
    unselectedItemColor: Color(0xFFD2B0FF),
    selectedIconTheme: IconThemeData(color: Color(0xFF1E0342)),
    unselectedIconTheme: IconThemeData(color: Color(0xFFD2B0FF)),
    selectedLabelStyle: TextStyle(color: Color(0xFF1E0342)),
    unselectedLabelStyle: TextStyle(color: Color(0xFFD2B0FF)),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);
