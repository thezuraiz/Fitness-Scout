import 'package:fitness_scout/common/widgets/grid_custom_widgets.dart';
import 'package:fitness_scout/common/widgets/list_tiles/settings_menue_title.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/features/gym/screen/home/widgets/home_grid.dart';
import 'package:fitness_scout/features/gym/screen/home/widgets/home_header.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(),

            // --- BODY
            Padding(
              padding: const EdgeInsets.all(ZSizes.defaultSpace),
              child: Column(
                children: [
                  // -- Heading
                  ZSectionHeading(
                    title: "Features",
                    onPressed: () {},
                    showActionButton: false,
                  ),
                  const SizedBox(height: ZSizes.spaceBtwItems * 0.5),
                  ZExercisesGrid(
                    children: [
                      GridCustomWidget(
                        icon: Iconsax.activity,
                        onPressed: () {},
                        buttonTitle: 'Exercises',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.home,
                        onPressed: () {},
                        buttonTitle: 'Up Coming Events',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.airdrop4,
                        onPressed: () {},
                        buttonTitle: 'Nearby GYMS',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.d_cube_scan,
                        onPressed: () {},
                        buttonTitle: 'Diet Plan',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.fatrows,
                        onPressed: () => Get.to(const BmiCalculator()),
                        buttonTitle: 'BMI',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.wallet,
                        onPressed: () {},
                        buttonTitle: 'My Package',
                      ),
                    ],
                  ),
                  const SizedBox(height: ZSizes.spaceBtwSections),
                  const ZSectionHeading(
                    title: 'Recommendation',
                    showActionButton: false,
                  ),
                  const SizedBox(height: ZSizes.spaceBtwItems),
                  ZSettingsMenueTitle(
                    icon: Iconsax.weight,
                    title: "Over Weight",
                    subTitle: "Check your Diet Plain Again",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.cup,
                    title: "Achievements",
                    subTitle: "See Your Achievements",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.warning_2,
                    title: "Package",
                    subTitle: "Package Expire Soon",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
