import 'package:fitness_scout/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_screen.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/deviceUtilities.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
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
                ZText.changeYourPasswordTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                ZText.changeYourPasswordSubTitle,
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
                  onPressed: () => Get.offAll(const LoginScreen()),
                  child: const Text(ZText.done),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: ()=> ForgetPasswordController.instance.resendPasswordResendEmail(email),
                  child: const Text(ZText.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
