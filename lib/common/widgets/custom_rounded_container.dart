import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../utils/constants/colors.dart';

class ZRoundedContainer extends StatelessWidget {
  const ZRoundedContainer(
      {super.key,
      this.height,
      this.width,
      this.radius = ZSizes.borderRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = ZColor.borderPrimary,
      this.backgroundColor = ZColor.white,
      this.padding,
      this.margin});

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
