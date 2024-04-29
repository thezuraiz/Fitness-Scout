import 'package:fitness_scout/common/widgets/formDivider.dart';
import 'package:fitness_scout/common/widgets/socialButtons.dart';
import 'package:fitness_scout/features/authentication/screen/signup_screen/verify_screen.dart';
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

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Header
              Text(
                ZText.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // TODO: FORM Section
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: ZText.firstName,
                          prefixIcon: Icon(Iconsax.user)),
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
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: ZText.email, prefixIcon: Icon(Iconsax.activity)),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: ZText.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: ZText.password,
                    prefixIcon: Icon(Iconsax.password_check),
                    suffixIcon: Icon(Iconsax.eye)),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(value: true, onChanged: (value) {}),
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
                  onPressed: () => Get.off(const VerifyScreen()),
                  child: const  Text(ZText.createAccount),
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
    );
  }
}
