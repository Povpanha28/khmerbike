import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryGreen = Color(0xFF22C55E);
  static const Color secondaryGreen = Color(0xFF10B981);
  static const Color accent = Colors.deepOrange;
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color borderColor = Color(0xFFE5E7EB);

  // Theme Data
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Primary color scheme
    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: secondaryGreen,
      surface: surface,
      background: background,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onBackground: textPrimary,
    ),

    // Scaffold
    scaffoldBackgroundColor: background,

    // AppBar
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: const TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),

    // Button styles
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Card
    cardTheme: CardThemeData(
      color: background,
      surfaceTintColor: Colors.transparent,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      labelStyle: const TextStyle(color: textSecondary),
    ),

    // Tab bar
    tabBarTheme: const TabBarThemeData(
      labelColor: textPrimary,
      unselectedLabelColor: textSecondary,
      indicatorColor: primaryGreen,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: background,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),

    // Text themes
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 0.5,
      space: 16,
    ),
  );
}
