import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class ZAppbarPadding{
  ZAppbarPadding._();

  static const EdgeInsetsGeometry appbarPadding = EdgeInsets.only(
    top: ZSizes.appBarHeight,
    left: ZSizes.defaultSpace,
    right: ZSizes.defaultSpace,
    bottom: ZSizes.defaultSpace,
  );
}