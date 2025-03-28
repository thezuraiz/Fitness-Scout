import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class GridCustomWidget extends StatelessWidget {
  const GridCustomWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.buttonTitle,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: dark ? ZColor.white.withOpacity(0.1) : ZColor.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: ZSizes.iconLg,
              color: ZColor.primary,
            ),
            const SizedBox(
              height: ZSizes.sm,
            ),
            Text(
              buttonTitle,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
