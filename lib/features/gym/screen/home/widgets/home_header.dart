import 'package:fitness_scout/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../../../utils/constants/sizes.dart';
import 'home_appbar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ZPrimaryHeaderContainer(
      child: Column(
        children: [

          // --- APPBAR
          const ZHomeAppbar(),
          const SizedBox(
            height: ZSizes.spaceBtwItems * 0.1,
          ),

          // --- BMI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZSizes.spaceBtwItems),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 'Healthy',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: ZColor.white),
                ),
                TextButton(
                  child: Text('BMI: 20',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: ZColor.grey),),
                  onPressed: ()=> Get.to(BmiCalculator()),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: ZSizes.spaceBtwItems * 0.6,
          ),

          // --- App Trainer Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZSizes.spaceBtwItems),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'We are loosing your weight.',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: ZColor.white),
                ),
              ],
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
