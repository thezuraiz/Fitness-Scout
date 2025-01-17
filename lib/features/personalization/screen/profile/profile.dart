import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:fitness_scout/common/widgets/list_tiles/settings_menue_title.dart';
import 'package:fitness_scout/common/widgets/list_tiles/user_profile.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/gym/screen/bmi/bmi_calculator.dart';
import 'package:fitness_scout/features/gym/screen/track_attendance/attendance_screen.dart';
import 'package:fitness_scout/features/personalization/controller/profile_page_controller.dart';
import 'package:fitness_scout/features/personalization/screen/profile/account_and_privacy_screen.dart';
import 'package:fitness_scout/features/personalization/screen/profile/notification_screen.dart';
import 'package:fitness_scout/features/personalization/screen/profile/profile_settings.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfilePageController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  ZCustomAppBar(
                    title: Text(
                      "Profile",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),

                  /// User Profile Card
                  ZUserProfileTile(
                    onPressed: () => Get.to(() => const SettingScreen()),
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ZSizes.defaultSpace),
              child: Column(
                children: [
                  const ZSectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwItems,
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subTitle: "See any kind of notification message",
                    onPressed: () => Get.to(() => const NotificationScreen()),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.security_card,
                    title: "Account and Privacy",
                    subTitle: "Manage data usage and connected accounts",
                    onPressed: () => Get.to(
                      () => const AccountAndPrivacyScreen(),
                    ),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.safe_home,
                    title: "Track My Attendance",
                    subTitle: "View All Gyms You Have Visited",
                    onPressed: () => Get.to(() => const TrackAttendance()),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.bag_tick,
                    title: "My BMI",
                    subTitle: "Your BMI, Monitor your health",
                    onPressed: () => Get.to(const BmiScreen()),
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),

                  /// --- App Settings
                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                  const ZSectionHeading(
                    title: "App Settings",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwItems,
                  ),
                  Obx(
                    () => ZSettingsMenueTitle(
                      icon: Iconsax.location,
                      title: "Geolocation",
                      subTitle: "Find GYM based on your location",
                      onPressed: () => controller.geoLocation.value =
                          !controller.geoLocation.value,
                      trailing: Switch(
                        value: controller.geoLocation.value,
                        onChanged: (value) =>
                            controller.geoLocation.value = value,
                      ),
                    ),
                  ),
                  Obx(
                    () => ZSettingsMenueTitle(
                      icon: Iconsax.image,
                      title: "HD Image Quality",
                      subTitle: "Set Image Quality to be seen",
                      onPressed: () => controller.hdImages.value =
                          !controller.hdImages.value,
                      trailing: Switch(
                        value: controller.hdImages.value,
                        onChanged: (value) => controller.hdImages.value = value,
                      ),
                    ),
                  ),

                  /// --- Logout Button

                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Text("Logout"),
                      onPressed: () => controller.logout(),
                    ),
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
