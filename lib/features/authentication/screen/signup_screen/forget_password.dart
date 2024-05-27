import 'package:fitness_scout/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
        appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: Form(
          key: controller.forgetKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Headings
              Text(ZText.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              const Text(ZText.forgetPasswordSubTitle),
              const SizedBox(
                height: ZSizes.spaceBtwSections * 2,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: ZText.email,
                  prefixIcon: Icon(Iconsax.direct_right)
                ),
                validator: controller.emailValidation(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.sendPasswordResendEmail(),
                  child: const Text(ZText.submit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
