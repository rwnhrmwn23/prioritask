import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // Colors
  static const Color primaryColor = Color(0xFFFF7171);
  static const Color secondaryColor = Color(0xFFFFF7F6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFB00020);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // UI Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color grey = Colors.grey;
  static Color grey300 = Colors.grey.shade300;
  static Color grey200 = Colors.grey.shade200;
  static Color grey600 = Colors.grey.shade600;

  // Priority Colors
  static Color priorityHighBg = Colors.red.shade100;
  static Color priorityHighText = Colors.red.shade700;
  static Color priorityMediumBg = Colors.orange.shade100;
  static Color priorityMediumText = Colors.orange.shade700;
  static Color priorityLowBg = Colors.blue.shade100;
  static Color priorityLowText = Colors.blue.shade700;
  static Color priorityTodoBg = Colors.grey.shade200;
  static Color priorityTodoText = Colors.grey.shade700;

  static const Color successGreen = Colors.green;
  static Color successGreenBg = Colors.green.shade100;

  // Text Styles
  static TextStyle get headlineMedium => GoogleFonts.buda(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get titleMedium => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );

  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static TextStyle get priorityLabel => GoogleFonts.buda(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        headlineMedium: headlineMedium,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        labelLarge: labelLarge,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: titleLarge,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }
}
