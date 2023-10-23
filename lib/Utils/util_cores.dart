import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color corPrimaria = const Color(0xff444C5E);
Color corSecundaria = const Color(0xff59C5C5);

ThemeData temaPrincipal = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: corPrimaria, background: const Color(0xffF0F0F0)),
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
      floatingLabelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: corPrimaria,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: corPrimaria,
    selectedItemColor: corSecundaria,
    unselectedItemColor: Colors.white,
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
  cardTheme: const CardTheme(
    color: Colors.white,
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
