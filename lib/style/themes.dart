import 'package:flutter/material.dart';

const Color bgColor1 = Color.fromARGB(255, 255, 255, 255);
const Color bgColor2 = Color.fromARGB(255, 37, 37, 38);

const Color primaryColor = Colors.orange;
const Color textColor1 = Colors.black54;
const Color textColor2 = Colors.white;

ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  primaryColor: bgColor2,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.dark,
  ),
);

ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  primaryColor: bgColor1,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.light,
  ),
);
