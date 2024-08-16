import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFFFFBC07),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.all<Color>(Colors.black)),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).copyWith(
      displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16),
      titleSmall: TextStyle(color: Colors.black, fontSize: 14),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xFF22262A),
    primaryColor: Color(0xFFFFBC07),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.all<Color>(Colors.white)),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
      titleMedium: TextStyle(color: Colors.white, fontSize: 16),
      titleSmall: TextStyle(color: Colors.white, fontSize: 14),
    ),
  );
}


extension CustomThemeData on ThemeData {
  Color get customContainerColor => brightness == Brightness.light
      ? Color(0xFFE0E0E0) // Light theme color
      : Color(0xFF333739); // Dark theme color
  Color get customAppColor => brightness == Brightness.light
      ? Color(0xFFE0E0E0) // Light theme color
      : Colors.black; // Dark theme color
  LinearGradient get customContainerGradient => brightness == Brightness.light
      ? LinearGradient(
    colors: [Color(0xFFF0F0F0), Color(0xFFE0E0E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  )
      : LinearGradient(
    colors: [Color(0xFF4A4A4A), Color(0xFF2C2C2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  List<BoxShadow>? get customBoxShadow => brightness == Brightness.dark
      ? [
    BoxShadow(
      blurRadius: 10.r, // Adjust according to your need
      spreadRadius: 2.r, // Adjust according to your need
      color: Colors.black.withOpacity(0.5),
    ),
  ]
      : null; // No shadow in light mode
}

