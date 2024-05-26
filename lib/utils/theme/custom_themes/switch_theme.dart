import 'package:flutter/material.dart';
import 'package:fitness_scout/utils/constants/colors.dart';

class ZSwitchTheme {
  ZSwitchTheme._();

  // --- LIGHT MODE
  static SwitchThemeData lightSwitchThemeData = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.withOpacity(0.4);
      }
      return ZColor.primary; // Use primary color for the thumb
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.withOpacity(0.4);
      }
      return ZColor.primary.withOpacity(0.2);
    }),
    splashRadius: 24,
  );

  // --- DARK MODE
  static SwitchThemeData darkSwitchThemeData = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return ZColor.primary.withOpacity(0.4);
      }
      return ZColor.primary; // Use primary color for the thumb
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return ZColor.primary.withOpacity(0.4);
      }
      return Colors.grey.withOpacity(0.2);
    }),
    splashRadius: 24,
  );
}
