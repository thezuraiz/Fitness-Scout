import 'package:fitness_scout/common/widgets/circular_image.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/image_string.dart';

class ZUserProfileTile extends StatelessWidget {
  const ZUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    return ListTile(
      // leading: const ZCircularImage(
      //   image: ZImages.userProfile,
      //   height: 50,
      //   width: 50,
      //   padding: 0,
      // ),
      leading: Obx(
        () => ZCircularImage(
          image: userController.user.value.profilePicture,
          isNetworkImage: true,
          height: 55,
          width: 55,
          padding: 0,
        ),
      ),
      title: Obx(
        () => Text(
          userController.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      subtitle: Obx(
        () => Text(
          userController.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Iconsax.edit,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
