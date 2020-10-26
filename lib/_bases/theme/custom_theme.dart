import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customTheme(context, {bool darkMode = false}) => ThemeData(
  visualDensity: !darkMode
      ? VisualDensity.adaptivePlatformDensity
      : VisualDensity.adaptivePlatformDensity,
  primaryColor:
      const Color.fromRGBO(0xFF, 0x45, 0x00, 1.0),
  backgroundColor: !darkMode
      ? Colors.white
      : const Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
  scaffoldBackgroundColor: !darkMode
      ? Colors.white
      : const Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
  iconTheme: !darkMode
      ? IconThemeData(color: Colors.grey[700])
      : IconThemeData(color: Colors.white),
  textTheme: GoogleFonts.nanumGothicTextTheme(Theme.of(context).textTheme).copyWith(
    headline1: TextStyle(
        color: Colors.black
    ),
    headline2: TextStyle(
        color: const Color.fromRGBO(0x6c, 0x6c, 0x6c, 1.0)
    ),
    headline3: TextStyle(
        color: const Color.fromRGBO(0x9c, 0x9c, 0x9c, 1.0)
    ),
    bodyText1: TextStyle(
        color: Colors.black
    ),
    bodyText2: TextStyle(
      color: Colors.black54
    ),
    subtitle1: TextStyle(
        color: Colors.black87
    ),
    subtitle2: TextStyle(
        color: Colors.grey[600]
    ),
  ),
  appBarTheme: !darkMode
      ? AppBarTheme(
        color: Colors.white,
      )
      : AppBarTheme(
        color: const Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
      ),
  dividerColor:  !darkMode
      ? Colors.black12
      : const Color(0x73000000),
  buttonColor: !darkMode
      ? Colors.black12
      : Colors.white70
);