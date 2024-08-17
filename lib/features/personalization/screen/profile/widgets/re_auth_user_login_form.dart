import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/user_controller.dart';

class ReAuthUserLoginForm extends StatelessWidget {
  const ReAuthUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Re-Authenticate User',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Email
                TextFormField(
                  validator: EmailValidator(errorText: 'Email Required').call,
                  controller: controller.verifyEmail,
                  decoration: const InputDecoration(
                    labelText: ZText.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),

                /// Password
                Obx(
                  () => TextFormField(
                    obscureText: !controller.hidePassword.value,
                    validator:
                        RequiredValidator(errorText: 'Password Required').call,
                    controller: controller.verifyPassword,
                    decoration: InputDecoration(
                      labelText: ZText.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),

                /// LOGIN Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPassword(),
                      child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
