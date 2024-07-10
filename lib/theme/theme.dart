import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade900,
  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade100,
    ));
