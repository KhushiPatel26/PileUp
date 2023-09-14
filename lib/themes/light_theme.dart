import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness:Brightness.light,
    appBarTheme: AppBarTheme(
      color: Color(0xFFFFFFFF),
      elevation: 10
    ),
    colorScheme:ColorScheme.light(
      background:Colors.white,
      primary:Colors.grey.shade100,
      secondary:Color(0xFF818181),
      tertiary: Color(0xFF1A1919),
    ),

);