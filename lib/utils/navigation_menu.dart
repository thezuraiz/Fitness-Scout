import 'package:fitness_scout/data/repositories/user/user_repository.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/diet_plan.dart';
import 'package:fitness_scout/features/gym/screen/home/home.dart';
import 'package:fitness_scout/features/gym_pool/screen/gym_pool.dart';
import 'package:fitness_scout/features/personalization/screen/profile/profile.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = ZHelperFunction.isDarkMode(context);
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          elevation: 0,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark
              ? ZColor.black.withOpacity(0.1)
              : ZColor.white.withOpacity(0.1),
          indicatorColor: dark
              ? ZColor.white.withOpacity(0.1)
              : ZColor.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Gyms'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Diet Plan'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
        body: controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();



  RxInt selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const GymPool(),
    const DietPlan(),
    const ProfileScreen()
  ];
}
