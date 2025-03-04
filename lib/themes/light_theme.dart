import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue.withValues(alpha: 76),
    selectionHandleColor: Colors.green,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(16),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontSize: 26,
    ),
    bodyLarge: TextStyle(color: Colors.black),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: TextStyle(fontWeight: FontWeight.w500),
      overlayColor: Colors.transparent,
    ),
  ),
  iconTheme: IconThemeData(size: 22, color: Colors.black),
  expansionTileTheme: ExpansionTileThemeData(
    collapsedTextColor: Colors.black,
    textColor: Colors.black,
    shape: const Border(
      top: BorderSide.none,
      bottom: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 0),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      iconColor: Colors.black,
      iconSize: 22,
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);
