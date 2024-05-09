import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/device/deviceUtilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ZCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZCustomAppBar(
      {super.key,
        this.title,
        this.showArrows = false,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed});

  final Widget? title;
  final bool showArrows;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ZSizes.md),
      child: AppBar(
          automaticallyImplyLeading: false,
          title: title,
          actions: actions,
          leading: showArrows
              ? IconButton(
              onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left))
              : leadingIcon != null
              ? IconButton(
              onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(ZDeviceUtils.getAppBarHeight());
}
