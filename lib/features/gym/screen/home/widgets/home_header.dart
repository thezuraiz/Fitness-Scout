import 'package:fitness_scout/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:fitness_scout/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import 'home_appbar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final dark = ZHelperFunction.isDarkMode(context);
    return ZPrimaryHeaderContainer(
      child: Column(
        children: [
          const SizedBox(
            height: ZSizes.spaceBtwItems * 0.2,
          ),
          // --- APPBAR
          const ZHomeAppbar(),
          const SizedBox(
            height: ZSizes.spaceBtwItems,
          ),

          // --- BMI
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: ZSizes.md),
            padding: const EdgeInsets.symmetric(horizontal: ZSizes.md),
            decoration: BoxDecoration(
              color: dark ? ZColor.dark : ZColor.white,
              borderRadius: BorderRadius.circular(ZSizes.cardRadiusLg),
              border: Border.all(color: dark ? ZColor.dark : ZColor.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Icon(Iconsax.direct_right),
                  Obx(
                    () => userController.profileLoading.value
                        ? const ZShimmerEffect(width: 50, height: 20)
                        : TextButton(
                            child: Text(
                              'BMI: ${userController.user.value.bmi.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(
                                      color: dark
                                          ? ZColor.light
                                          : ZColor.darkerGrey),
                            ),
                            onPressed: () => Get.to(const BmiScreen()),
                          ),
                  ),
                ]),
                Obx(
                  () => userController.profileLoading.value
                      ? const ZShimmerEffect(width: 50, height: 20)
                      : Text(
                          BmiCalculator.getBmiMessage(
                              userController.user.value.bmi),
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? ZColor.light : ZColor.darkerGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: ZSizes.spaceBtwSections,
          ),

          // --- App Trainer Message
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: ZSizes.spaceBtwItems),
            child: Obx(
              () => userController.profileLoading.value
                  ? const ZShimmerEffect(width: 50, height: 20)
                  : Text(
                      BmiCalculator.getAppMessage(
                          userController.user.value.bmi),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(color: ZColor.white),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwSections + 20,
          ),
        ],
      ),
    );
  }
}
