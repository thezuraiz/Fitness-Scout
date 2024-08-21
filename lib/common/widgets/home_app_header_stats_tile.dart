import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class HomeAppHeaderStatsTile extends StatelessWidget {
  const HomeAppHeaderStatsTile(
      {super.key,
      required this.icon,
      required this.buttonText,
      required this.onPressed});

  final IconData icon;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: ZColor.light,
        ),
        TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: ZColor.light),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
