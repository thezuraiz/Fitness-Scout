import 'package:flutter/material.dart';
import 'package:fitness_scout/utils/constants/colors.dart';

class ZSwitchTheme {
  ZSwitchTheme._();

  // --- LIGHT MODE
  static SwitchThemeData lightSwitchThemeData = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.withOpacity(0.4);
      }
      return ZColor.primary; // Use primary color for the thumb
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.withOpacity(0.4);
      }
      return ZColor.primary.withOpacity(0.2);
    }),
    splashRadius: 24,
  );

  // --- DARK MODE
  static SwitchThemeData darkSwitchThemeData = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return ZColor.primary.withOpacity(0.4);
      }
      return ZColor.primary; // Use primary color for the thumb
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return ZColor.primary.withOpacity(0.4);
      }
      return Colors.grey.withOpacity(0.2);
    }),
    splashRadius: 24,
  );
}
