import 'package:fitness_scout/common/widgets/formDivider.dart';
import 'package:fitness_scout/common/widgets/socialButtons.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/signup_controller.dart';
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
                        controller: controller.firstNameController,
                        validator: controller.nameValidator,
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
                        controller: controller.lastNameController,
                        validator: controller.nameValidator,
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
                  controller: controller.userNameController,
                  validator: controller.usernameValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: ZText.email,
                      prefixIcon: Icon(Iconsax.activity)),
                  controller: controller.emailController,
                  validator: controller.emailValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: ZText.phoneNo,
                    prefixIcon: Icon(Iconsax.call),
                  ),
                  controller: controller.phoneNumberController,
                  validator: controller.phoneNumberValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                Obx(() => TextFormField(
                      decoration: InputDecoration(
                        labelText: ZText.password,
                        prefixIcon: Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: () => controller.showPassword.value =
                              !controller.showPassword.value,
                          icon: Icon(controller.showPassword.value
                              ? Iconsax.eye
                              : Iconsax.eye_slash),
                        ),
                      ),
                      controller: controller.passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: controller.passwordValidator,
                      obscureText: controller.showPassword.value,
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
                          value: controller.iAgreeTo.value,
                          onChanged: (value) =>
                              controller.iAgreeTo.value = value!,
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
                    onPressed: controller.createAccountButton,
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
                const ZSocialButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
