import 'package:fitness_scout/common/widgets/circular_image.dart';
import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/personalization/screen/profile/widgets/profile_menu.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text("Profile",style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Column(
            children: [
              // --- Profile Screen
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const ZCircularImage(image: ZImages.userProfile,height: 100,width: 100,),
                    TextButton(
                        onPressed: () {}, child: const Text("Change Profile Picture"))
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
              ProfileMenu(
                  title: "Name", subTitle: "Zuraiz Khan", onPressed: () {}),
              ProfileMenu(
                  title: "Username",
                  subTitle: "thezuraiz",
                  onPressed: () {}),
              ProfileMenu(
                  title: "GYM Package",
                  subTitle: "Diamond",
                  onPressed: () {}),

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
              ProfileMenu(
                  title: "User ID",
                  subTitle: '45877',
                  icon: Iconsax.copy,
                  onPressed: () {}),
              ProfileMenu(
                  title: "Email", subTitle: 'thezuraiz@gmail.com', onPressed: () {}),
              ProfileMenu(
                  title: "Phone Number",
                  subTitle: '0300-1234029',
                  onPressed: () {}),
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
                  onPressed: () {},
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
