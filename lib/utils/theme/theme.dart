import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/theme/custom_themes/appbar_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/check_box_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/chip_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/icon_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/outlined_button.dart';
import 'package:fitness_scout/utils/theme/custom_themes/switch_theme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/textTheme.dart';
import 'package:fitness_scout/utils/theme/custom_themes/textformfield_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // --- Light Theme
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: const Color(0xff007BFF),
      scaffoldBackgroundColor: Colors.white,
      textTheme: ZTextTheme.lightTextTheme,
      chipTheme: ZChipTheme.lightChipThemeData,
      appBarTheme: ZAppBarTheme.lightAppBarTheme,
      checkboxTheme: ZCheckBoxTheme.ligthCheckboxTheme,
      bottomSheetTheme: ZBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: ZElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: ZOutlinedButton.lightOutlinedButtonTheme,
      inputDecorationTheme: ZTextFormFieldTheme.lightTextFormField,
      switchTheme: ZSwitchTheme.lightSwitchThemeData,
      iconTheme: ZIconTheme.lightIconTheme);

  // --- Dark Theme
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: const Color(0xff005B5B),
      scaffoldBackgroundColor: ZColor.black,
      textTheme: ZTextTheme.darkTextTheme,
      chipTheme: ZChipTheme.darkChipThemeData,
      appBarTheme: ZAppBarTheme.darkAppBarTheme,
      checkboxTheme: ZCheckBoxTheme.darkCheckBoxTheme,
      bottomSheetTheme: ZBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: ZElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: ZOutlinedButton.darkOutlinedButtonTheme,
      inputDecorationTheme: ZTextFormFieldTheme.darkTextFormField,
      switchTheme: ZSwitchTheme.darkSwitchThemeData,
      iconTheme: ZIconTheme.darkIconTheme);
}
