import 'package:fitness_scout/common/styles/AppbarPadding.dart';
import 'package:fitness_scout/common/widgets/formDivider.dart';
import 'package:fitness_scout/common/widgets/socialButtons.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/login_controller.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/forget_password.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/signup_screen.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:fitness_scout/utils/navigation_menu.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              // Todo: Header -> Logo,title, subTitle
              LoginScreenHeader(),

              // Todo: Form
              LoginScreenFormField(),

              // TODO: Divider
              ZFormDivider(
                dividerText: ZText.orSignUpWith,
              ),

              SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // TODO: Footer
              ZSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreenFormField extends StatelessWidget {
  const LoginScreenFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    final formKey = GlobalKey<FormState>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwSections),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: ZText.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
                controller: controller.emailController,
                validator: controller.emailValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    suffixIcon: Icon(Iconsax.eye),
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: ZText.password),
                controller: controller.passwordController,
                validator: controller.passwordValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwInputFields / 2,
              ),

              // TODO: Remember Me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) =>
                          controller.rememberMe.value = value!),
                      ),
                      const Text(ZText.rememberMe)
                    ],
                  ),

                  // TODO: Forget Password
                  TextButton(
                    onPressed: () => Get.to(const ForgetPassword()),
                    child: const Text(ZText.forgetPassword),
                  )
                ],
              ),

              // TODO: Sign In Button
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus!.unfocus();
                      Get.to(() => const NavigationMenu());
                    }
                  },
                  child: const Text(ZText.signIn),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(ZText.createAccount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: ZSizes.lg,
        ),
        Image.asset(
            height: 100, dark ? ZImages.darkAppLogo : ZImages.lightAppLogo),
        const SizedBox(
          height: ZSizes.sm,
        ),
        Text(
          ZText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ZSizes.sm,
        ),
        Text(
          ZText.loginSubTitle,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
