import 'package:flutter/material.dart';

class ZOutlinedButton{
  ZOutlinedButton._();

  static final OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white),
      textStyle: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );

  static final OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.blue),
      textStyle: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
    )
  );
}