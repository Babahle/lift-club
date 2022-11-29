import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPrimarySwatch {
  static final Map<int, Color> colors = {
    50: const Color.fromRGBO(255, 160, 122, .1),
    100: const Color.fromRGBO(255, 160, 122, .2),
    200: const Color.fromRGBO(255, 160, 122, .3),
    300: const Color.fromRGBO(255, 160, 122, .4),
    400: const Color.fromRGBO(255, 160, 122, .5),
    500: const Color.fromRGBO(255, 160, 122, .6),
    600: const Color.fromRGBO(255, 160, 122, .7),
    700: const Color.fromRGBO(255, 160, 122, .8),
    800: const Color.fromRGBO(255, 160, 122, .9),
    900: const Color.fromRGBO(255, 160, 1229, 1),
  };
}

class MyColors {
  static const Color background = Color.fromRGBO(0, 27, 46, 100);
  static const Color widgetsBackground = Color.fromRGBO(0, 46, 79, 100);
  static const Color heading = Color.fromRGBO(255, 160, 122, 100);
  static const Color body = Color.fromRGBO(237, 255, 236, 100);
  static MaterialColor primarySwatch = MaterialColor(
      const Color.fromRGBO(255, 160, 122, 100).value, MyPrimarySwatch.colors);
}

class MainTheme {
  static ThemeData mainTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColors.background,
    primarySwatch: MyColors.primarySwatch,
    // ignore: prefer_const_constructors
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    primaryColor: MyColors.body,
    textTheme: TextTheme(
        headlineSmall: GoogleFonts.ptSans(
            color: MyColors.heading, fontWeight: FontWeight.w800),
        headlineMedium: GoogleFonts.ptSans(
            color: MyColors.heading, fontWeight: FontWeight.w800),
        headlineLarge: GoogleFonts.ptSans(
            color: MyColors.heading, fontWeight: FontWeight.w800),
        titleSmall: GoogleFonts.ptSans(color: MyColors.body),
        titleMedium: GoogleFonts.ptSans(color: MyColors.body),
        titleLarge: GoogleFonts.ptSans(color: MyColors.body),
        bodySmall: GoogleFonts.ptSans(color: MyColors.body),
        bodyMedium: GoogleFonts.ptSans(color: MyColors.body),
        bodyLarge: GoogleFonts.ptSans(color: MyColors.body)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(MyColors.heading),
      textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(color: MyColors.heading)),
      backgroundColor:
          MaterialStateProperty.all<Color>(MyColors.widgetsBackground),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(MyColors.heading),
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: MyColors.heading)),
        backgroundColor:
            MaterialStateProperty.all<Color>(MyColors.widgetsBackground),
      ),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.background,
        foregroundColor: MyColors.heading),

    iconTheme: const IconThemeData(color: MyColors.heading),
    cardTheme: const CardTheme(
      color: MyColors.widgetsBackground,
    )
  );
}
