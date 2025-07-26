// This code is create by M23W7502_ThetPaingOo
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.aBeeZee(color: Colors.black),
    bodyLarge: GoogleFonts.aBeeZee(color: Colors.black),
    bodySmall: GoogleFonts.padauk(color: Colors.black),
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.aBeeZee(color: Colors.white),
    bodyLarge: GoogleFonts.aBeeZee(color: Colors.white),
    bodySmall: GoogleFonts.aBeeZee(color: Colors.white),
  ),
);
