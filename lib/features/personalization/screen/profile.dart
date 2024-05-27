import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:fitness_scout/common/widgets/list_tiles/settings_menue_title.dart';
import 'package:fitness_scout/common/widgets/list_tiles/user_profile.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/features/authentication/controller/login/login_controller.dart';
import 'package:fitness_scout/features/personalization/screen/profile_settings.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ZUserProfileTile(onPressed: ()=> Get.to(()=>const SettingScreen()),),
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
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subTitle: "Set our location",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.bag_tick,
                    title: "My BMI",
                    subTitle: "Your BMI, Monitor your health",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subTitle: "Buy Package through Bank",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    onPressed: () {},
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.security_card,
                    title: "Account and Privacy",
                    subTitle: "Manage data usage and connected accounts",
                    onPressed: () {},
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
                  ZSettingsMenueTitle(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subTitle: "Find GYM based on your location",
                    onPressed: () {},
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subTitle: "Search result is safe for all Ages",
                    onPressed: () {},
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ZSettingsMenueTitle(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subTitle: "Set Image Quality to be seen",
                    onPressed: () {},
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
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
                      onPressed: () => AuthenticationRepository.instance.logout(),
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
