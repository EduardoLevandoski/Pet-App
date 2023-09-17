import 'package:flutter/material.dart';

Color corPrimaria = const Color(0xff444C5E);
Color corSecundaria = const Color(0xff59C5C5);

ThemeData temaPrincipal = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: corPrimaria),
  appBarTheme: AppBarTheme(
    backgroundColor: corPrimaria,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: corPrimaria,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)),
    ),
  ),
  useMaterial3: true,
);
