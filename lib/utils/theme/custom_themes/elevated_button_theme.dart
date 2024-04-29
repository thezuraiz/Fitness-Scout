import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ZElevatedButtonTheme{

  ZElevatedButtonTheme._(); // make it private

  // --- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: ZColor.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: ZColor.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // --- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: ZColor.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: ZColor.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

}