import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ZShadowStyle{
  static final verticalProductShadow = BoxShadow(
    color: ZColor.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
      color: ZColor.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}