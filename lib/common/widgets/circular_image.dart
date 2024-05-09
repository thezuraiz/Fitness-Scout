import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ZCircularImage extends StatelessWidget {
  const ZCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.height = 56,
    this.width = 56,
    this.padding = ZSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor, backgroundColor;
  final double height, width, padding;

  @override
  Widget build(BuildContext context) {
    final bool dark = ZHelperFunction.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: dark ? ZColor.black : ZColor.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
        color: overlayColor,
      ),
    );
  }
}
