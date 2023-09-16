import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 62, 132, 207),
        secondary: Color.fromARGB(255, 24, 74, 148),
        onBackground: Color.fromARGB(255, 65, 65, 65),
        background: Colors.white),
    appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 62, 132, 207)),
    useMaterial3: true,
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
      decorationColor: Colors.white,
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 100, 100, 100)),
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white, selectionColor: Colors.black45),
    iconTheme: const IconThemeData(color: Colors.white),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 210, 210, 210),
      secondary: Color.fromARGB(255, 33, 33, 33),
      background: Color.fromARGB(255, 49, 49, 49),
    ),
    useMaterial3: true,
  );
}
