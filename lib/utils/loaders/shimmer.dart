import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class ZShimmerEffect extends StatelessWidget {
  const ZShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(ZSizes.md),
        decoration: BoxDecoration(
            color: color ?? (dark ? ZColor.darkGrey : ZColor.white),
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
