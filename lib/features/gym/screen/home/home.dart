import 'package:fitness_scout/common/widgets/blank_screen.dart';
import 'package:fitness_scout/common/widgets/grid_custom_widgets.dart';
import 'package:fitness_scout/common/widgets/list_tiles/settings_menue_title.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/diet_plan.dart';
import 'package:fitness_scout/features/gym/screen/home/widgets/home_grid.dart';
import 'package:fitness_scout/features/gym/screen/home/widgets/home_header.dart';
import 'package:fitness_scout/features/gym/screen/track_attendance/attendance_screen.dart';
import 'package:fitness_scout/features/gym/screen/upcoming_events/upcoming_event.dart';
import 'package:fitness_scout/features/gym_pool/controller/gym_pool_controller.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../utils/navigation_menu.dart';
import '../../controller/bmi/bmi_controller.dart';
import '../../controller/diet_plan/diet_plan_controller.dart';
import '../../controller/upcoming_events/upcoming_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BMIx = Get.put(BmiController());
    // final GYM = Get.put(GymPoolController());
    Get.put(DietPlanController());
    Get.put(UpcomingEventsController());
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
                        onPressed: () => Get.to(const BmiScreen()),
                        buttonTitle: 'BMI',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.home,
                        onPressed: () => Get.to(const UpcomingEventsScreen()),
                        buttonTitle: 'UpComing Events',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.airdrop4,
                        onPressed: () => NavigationController
                            .instance.selectedIndex.value = 1,
                        buttonTitle: 'Nearby GYMS',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.d_cube_scan,
                        onPressed: () => Get.to(const BmiScreen()),
                        buttonTitle: 'Diet Plan',
                      ),
                      GridCustomWidget(
                        icon: Iconsax.fatrows,
                        onPressed: () => Get.to(const TrackAttendance()),
                        buttonTitle: 'Track Attendance',
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
                    onPressed: () => Get.to(() => const BlankScreen()),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.cup,
                    title: "Achievements",
                    subTitle: "See Your Achievements",
                    onPressed: () => Get.to(() => const BlankScreen()),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.warning_2,
                    title: "Package",
                    subTitle: "Package Expire Soon",
                    onPressed: () => Get.to(() => const BlankScreen()),
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
