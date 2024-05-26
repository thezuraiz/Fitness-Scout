import 'package:flutter/material.dart';

class ZColor{
  ZColor._();

  // --- APP BASIC COLORS
  static const primary = Color(0xFFF77B00);
  // static const primary = Color(0xff4b68ff);
  static const secondary = Color(0xffa1d8f1);
  // static const secondary = Color(0xffffe24b);
  static const accent = Color(0xFFff8d61);

  // -- GRADIENT COLOR
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
    Color(0xFFFf9A9e),
    Color(0xFFFad0c4),
    Color(0xFFFad0c4),
  ]);

  // --- TEXT COLORS
  static const textPrimary = Color(0xff333333);
  static const textSecondary = Color(0xFF6c757D);
  static const textWhite = Colors.white;

  // --- BACKGROUND COLORS
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5FF);

  // --- BACKGROUND CONTAINER COLOR
  static const Color lightContainer = Color(0xffff6f6f6);
  static Color darkContainer = ZColor.white.withOpacity(0.1);

  // --- BUTTON COLORS
  static const Color buttonPrimary = Color(0xFFff8d61);
  static const Color buttonSecondary = Color(0xFFa1d8f1);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

  // --- BORDER COLORS
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // --- ERROR AND VALIDATION COLOR
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0x0fff57c0);
  static const Color info = Color(0xFF1976D2);

  // --- NEUTRAL SHADES
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

}