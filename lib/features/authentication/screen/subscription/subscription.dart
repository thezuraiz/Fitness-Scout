import 'package:fitness_scout/common/styles/AppbarPadding.dart';
import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/features/authentication/controller/subscription/subscription_controller.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key, this.toPay = "0"});

  final String toPay;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          ZText.orderReviewAppbarTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.copyIban,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(ZImages.fitnessScoutBankQRCode),
                      ),
                      const SizedBox(
                        height: ZSizes.spaceBtwItems,
                      ),
                      Text(
                        "Bank SadaPay",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: ZSizes.spaceBtwItems * 0.6,
                      ),
                      const Text("IBAN: ${ZText.fitnessScoutBankIBAN}")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems * 0.6,
              ),
              Text(
                "To Pay: $toPay",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections * 1.4,
              ),
              Form(
                key: controller.orderFormKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: ZText.orderReviewReferenceFieldTitle,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "Required"),
                      // RangeValidator(min: 5, max: 20, errorText: "Invalid ID"),
                    ],
                  ).call,
                ),
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: controller.bankScreenshotTransfer,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: controller.photo != null
                            ? Colors.blue
                            : Colors.transparent),
                    child: const Text('Bank Transfer Screenshot'),
                  )
                ],
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections * 1.5,
              ),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: controller.submitForm,
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
