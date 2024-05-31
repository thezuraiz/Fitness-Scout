import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ZSettingsMenueTitle extends StatelessWidget {
  const ZSettingsMenueTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing, required this.onPressed,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: ZColor.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZSizes.md)),
    );
  }
}
