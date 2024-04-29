import 'package:flutter/material.dart';

class ZChipTheme{
  ZChipTheme._();

  // --- LIGHT MODE
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
    checkmarkColor: Colors.white
  );

  // --- DARK MODE
  static ChipThemeData darkChopThemeData = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
    checkmarkColor: Colors.white
  );
}