import 'package:flutter/material.dart';

class ZAppBarTheme{
  ZAppBarTheme._(); // Private its Constructor

  // --- LIGHT THEME
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black,size: 24),
    titleTextStyle: TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.w600),
  );

  // --- DARK THEME
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white,size: 24),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600,)
  );
}