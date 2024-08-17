import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/change_name_controller.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headline
            Text(
              'Use real name for easy verification. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator:
                        RequiredValidator(errorText: 'Required First Name!').call,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: ZText.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(
                    height: ZSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.lastName,
                    validator:
                        RequiredValidator(errorText: 'Required Last Name!').call,
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: ZText.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections,
            ),

            /// Saved Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
