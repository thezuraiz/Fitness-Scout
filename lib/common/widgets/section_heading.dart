import 'package:flutter/material.dart';

class ZSectionHeading extends StatelessWidget {
  const ZSectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = 'View All',
    this.onPressed,
    this.textColor,
    this.showActionButton = true,
  });

  final String title, buttonTitle;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}