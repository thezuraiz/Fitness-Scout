import 'package:flutter/material.dart';

class ZCircularContainer extends StatelessWidget {
  const ZCircularContainer({
    super.key,
    this.child,
    this.height = 400,
    this.width = 400,
    this.radius = 400,
    required this.backgroundColor,
    this.margin,
    this.padding = 0,
  });

  final double? height;
  final double? width;
  final Widget? child;
  final double? radius;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
