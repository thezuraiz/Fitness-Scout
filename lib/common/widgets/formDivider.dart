import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class ZFormDivider extends StatelessWidget {
  const ZFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Row(
      children: [
        Flexible(
          child: Divider(
            color: dark ? ZColor.darkGrey : ZColor.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? ZColor.darkGrey : ZColor.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        )
      ],
    );
  }
}