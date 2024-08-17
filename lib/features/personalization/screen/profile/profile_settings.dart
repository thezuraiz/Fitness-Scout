import 'package:fitness_scout/common/widgets/circular_image.dart';
import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/personalization/controller/user_controller.dart';
import 'package:fitness_scout/features/personalization/screen/profile/widgets/change_name.dart';
import 'package:fitness_scout/features/personalization/screen/profile/widgets/profile_menu.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/loaders/shimmer.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Column(
            children: [
              // --- Profile Screen
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : ZImages.userProfile;
                      return controller.profileLoading.value
                          ? const ZShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : ZCircularImage(
                              image: image,
                              isNetworkImage: networkImage.isNotEmpty,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            );
                    }),
                    TextButton(
                        onPressed: () =>
                            UserController.instance.uploadUserProfilePicture(),
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),

              // --- Details Page
              const SizedBox(
                height: ZSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),

              /// --- Profile Info
              const ZSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                    title: "Name",
                    subTitle: controller.user.value.fullName,
                    onPressed: () => Get.to(() => const ChangeNameScreen())),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Username",
                    subTitle: controller.user.value.userName,
                    onPressed: () {}),
              ),
              ProfileMenu(
                  title: "GYM Package", subTitle: "Diamond", onPressed: () {}),

              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),

              /// --- Personal Information
              const ZSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Obx(
                () => ProfileMenu(
                    title: "User ID",
                    subTitle: controller.user.value.id,
                    icon: Iconsax.copy,
                    onPressed: () {}),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Email",
                    subTitle: controller.user.value.email,
                    onPressed: () {}),
              ),
              Obx(
                () => ProfileMenu(
                    title: "Phone Number",
                    subTitle: controller.user.value.phoneNumber,
                    onPressed: () {}),
              ),
              ProfileMenu(title: "Gender", subTitle: 'Male', onPressed: () {}),
              ProfileMenu(
                  title: "Date of Birth",
                  subTitle: '11-Aug-2023',
                  onPressed: () {}),
              const Divider(),
              const SizedBox(
                height: ZSizes.defaultSpace,
              ),

              /// --- Close Account
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: const Text("Close Account",
                      style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
