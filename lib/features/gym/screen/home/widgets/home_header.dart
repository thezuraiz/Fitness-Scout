import 'package:fitness_scout/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:fitness_scout/common/widgets/home_app_header_stats_tile.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
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
    final userController = Get.put(UserController());
    // userController.fetchUserRecord();
    return ZPrimaryHeaderContainer(
      child: Stack(
        children: [
          Positioned(
            top: 100,
            right: 15,
            child:
                Image.asset('assets/artworks/fitness_scout_home_artwork.png'),
            width: Get.width - 200,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: ZSizes.spaceBtwItems * 0.2,
              ),
              // --- APPBAR
              const ZHomeAppbar(),
              const SizedBox(
                height: ZSizes.spaceBtwItems * 5,
              ),

              Container(
                padding: const EdgeInsets.only(
                    left: ZSizes.defaultSpace, bottom: ZSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.chart_3,
                          color: ZColor.lightGrey,
                          size: 90,
                        )),
                    Obx(
                      () => userController.profileLoading.value
                          ? const ZShimmerEffect(width: 50, height: 20)
                          : HomeAppHeaderStatsTile(
                              icon: Iconsax.direct_right,
                              buttonText:
                                  'BMI: ${userController.user.value.bmi.toStringAsFixed(2)}',
                              onPressed: () => Get.to(
                                const BmiScreen(),
                              ),
                            ),
                    ),
                    Obx(
                      () => userController.profileLoading.value
                          ? const ZShimmerEffect(width: 50, height: 20)
                          : HomeAppHeaderStatsTile(
                              icon: Iconsax.check,
                              buttonText: BmiCalculator.getBmiMessage(
                                  userController.user.value.bmi),
                              onPressed: () => Get.to(
                                const BmiScreen(),
                              ),
                            ),
                    ),
                    Obx(
                      () => userController.profileLoading.value
                          ? const ZShimmerEffect(width: 50, height: 20)
                          : HomeAppHeaderStatsTile(
                              icon: Iconsax.star_1,
                              buttonText: '240 kcal burned',
                              onPressed: () => Get.to(
                                const BmiScreen(),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: ZSizes.md,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
