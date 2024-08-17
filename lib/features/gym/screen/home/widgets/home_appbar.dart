import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/features/personalization/screen/profile/profile.dart';
import 'package:fitness_scout/features/personalization/screen/profile/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controller/user_controller.dart';

class ZHomeAppbar extends StatelessWidget {
  const ZHomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ZCustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ZText.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: ZColor.grey),
          ),
          Obx(
            () => Text(
              controller.user.value.fullName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: ZColor.white),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() => const SettingScreen()),
          icon: const Icon(
            Iconsax.user,
            color: ZColor.white,
          ),
        ),
      ],
    );
  }
}
