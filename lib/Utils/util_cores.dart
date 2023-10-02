import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color corPrimaria = const Color(0xff444C5E);
Color corSecundaria = const Color(0xff59C5C5);
Color corTerciara = const Color(0xffe8eefa);

ThemeData temaPrincipal = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: corPrimaria),
  textTheme: GoogleFonts.robotoTextTheme(),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
    backgroundColor: corPrimaria,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: corSecundaria,
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      floatingLabelStyle: TextStyle(color: corSecundaria),
      contentPadding: const EdgeInsets.all(12.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: corSecundaria),
      )),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: corPrimaria,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  ),
  drawerTheme: const DrawerThemeData(
    shadowColor: Colors.white,
    shape: BeveledRectangleBorder(),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
    ),
  ),
  cardTheme: CardTheme(
    color: corTerciara,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: corSecundaria,
    foregroundColor: Colors.white,
    shape: const OvalBorder(),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: corSecundaria,
    indicatorColor: corSecundaria,
    unselectedLabelColor: Colors.white,
  ),
  useMaterial3: true,
);
