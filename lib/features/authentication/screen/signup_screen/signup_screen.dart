import 'package:fitness_scout/common/widgets/formDivider.dart';
import 'package:fitness_scout/common/widgets/socialButtons.dart';
import 'package:fitness_scout/features/authentication/controller/signup/signup_controller.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    SignupController controller = Get.put(SignupController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ZText.signupTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: ZSizes.spaceBtwSections * 2,
                ),

                // TODO: FORM Section
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: ZText.firstName,
                            prefixIcon: Icon(Iconsax.user)),
                        controller: controller.firstName,
                        validator: controller.nameValidator.call,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(
                      width: ZSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: ZText.lastName,
                            prefixIcon: Icon(Iconsax.user)),
                        controller: controller.lastName,
                        validator: controller.nameValidator.call,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: ZText.userName,
                      prefixIcon: Icon(Iconsax.user_edit)),
                  controller: controller.userName,
                  validator: controller.usernameValidator.call,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: ZText.email,
                      prefixIcon: Icon(Iconsax.activity)),
                  controller: controller.email,
                  validator: controller.emailValidator.call,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: ZText.height,
                          prefixIcon: Icon(Icons.height)
                        ),
                        controller: controller.height,
                        validator: controller.heightValidator.call,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(
                      width: ZSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: ZText.weight,prefixIcon: Icon(Iconsax.weight)),
                        controller: controller.weight,
                        validator: controller.weightValidator.call,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: ZText.phoneNo,
                    prefixIcon: Icon(Iconsax.call),
                  ),
                  controller: controller.phoneNumber,
                  validator: controller.phoneNumberValidator.call,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                Obx(() => TextFormField(
                      decoration: InputDecoration(
                        labelText: ZText.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye
                              : Iconsax.eye_slash),
                        ),
                      ),
                      controller: controller.password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.passwordValidator.call,
                      obscureText: controller.hidePassword.value,
                    )),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Obx(
                        () => Checkbox(
                          value: controller.privacyPolicy.value,
                          onChanged: (value) =>
                              controller.privacyPolicy.value = value!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: ZSizes.md,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '${ZText.iAgreeTo} ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                          text: '${ZText.privacyPolicy} ',
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: dark ? Colors.white : ZColor.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    dark ? Colors.white : ZColor.primary,
                              ),
                        ),
                        TextSpan(
                            text: 'and ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                          text: '${ZText.termsOfUse} ',
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: dark ? Colors.white : ZColor.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    dark ? Colors.white : ZColor.primary,
                              ),
                        ),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.signup,
                    child: const Text(ZText.createAccount),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                const ZFormDivider(dividerText: ZText.orSignUpWith),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                const ZSocialButtons(),
                const SizedBox(
                  height: ZSizes.defaultSpace,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
