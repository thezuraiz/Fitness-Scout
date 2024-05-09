import 'package:fitness_scout/common/styles/AppbarPadding.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_screen.dart';
import 'package:fitness_scout/features/authentication/controller/signup_controller.dart';
import 'package:fitness_scout/features/authentication/screen/successScreens.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:fitness_scout/utils/device/deviceUtilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              // --- TODO: Image
              Image.asset(
                ZImages.deliveredEmailIllustration,
                width: ZDeviceUtils.getScreenWidth() * 0.6,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              // --- TODO: Title & Subtitle
              Text(
                ZText.confirmEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                "support@codingwitht.com",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                ZText.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // --- TODO: Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(SuccessScreen(
                    image: ZImages.staticSuccessIllustration,
                    title: ZText.yourAccountCreatedTitle,
                    subTitle: ZText.yourAccountCreatedSubTitle,
                    onPressed: () => Get.off(const LoginScreen()),
                  )),
                  child: const Text(ZText.Continue),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.resendEmailButton,
                  child: const Text(ZText.resendEmail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
