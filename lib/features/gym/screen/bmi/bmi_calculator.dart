import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/features/gym/controller/bmi/bmi_controller.dart';
import 'package:fitness_scout/features/gym/controller/diet_plan/diet_plan_controller.dart';
import 'package:fitness_scout/features/gym/screen/bmi/widgets/bmi_calculator_radical_meter.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:fitness_scout/utils/helpers/bmi_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class BmiScreen extends StatelessWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DietPlanController());
    final controller = Get.put(BmiController());
    final dietplan = DietPlanController.instance;

    return Scaffold(
      appBar: ZCustomAppBar(
        title: Text(
          "BMI Calculator",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showArrows: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Form(
            key: controller.bmiKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(() => controller.bmi.value == 0
                    ? Lottie.asset(ZImages.bmiAnimation)
                    : RadicalMeter(
                        bmiMessage:
                            BmiCalculator.getBmiMessage(controller.bmi.value),
                        bmi: controller.bmi.value)),
                const SizedBox(
                  height: ZSizes.spaceBtwSections,
                ),
                Text(
                  ZText.bmiScreenHeading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwItems,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Weight (In KG's)",
                    prefixIcon: Icon(
                      CupertinoIcons.heart_fill,
                      color: ZColor.primary,
                    ),
                  ),
                  controller: controller.weight,
                  validator: controller.weightValidator.call,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.align_vertically,
                      color: ZColor.primary,
                    ),
                    labelText: "Height (In Feets)",
                  ),
                  controller: controller.height,
                  validator: controller.heightValidator.call,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: ZSizes.spaceBtwSections * 4.5,
                ),
                // Spacer(),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: () => controller.calculateBMI(),
                    child: const Text(
                      "Calculate",
                    ),
                  ),
                ),
                SizedBox(
                  height: ZSizes.spaceBtwInputFields,
                ),
                SizedBox(
                  width: Get.width,
                  child: OutlinedButton(
                    onPressed: dietplan.generateDietPlan,
                    child: const Text(
                      "Generate Diet Plan",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
