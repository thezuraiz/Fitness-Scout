import 'package:fitness_scout/features/authentication/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';

class ZSocialButtons extends StatelessWidget {
  const ZSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: ZColor.grey)),
          child: IconButton(
            onPressed: () => controller.signupWithGoogle(),
            icon: const Image(
              height: ZSizes.iconMd,
              width: ZSizes.iconMd,
              image: AssetImage(ZImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: ZSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: ZColor.grey)),
          child: IconButton(
            onPressed: () => controller.signupWithFacebook(),
            icon: const Image(
              height: ZSizes.iconMd,
              width: ZSizes.iconMd,
              image: AssetImage(ZImages.facebook),
            ),
          ),
        )
      ],
    );
  }
}