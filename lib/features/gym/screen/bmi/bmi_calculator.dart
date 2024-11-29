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
        child: Padding(
          padding: const EdgeInsets.all(ZSizes.defaultSpace),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => controller.bmi.value == 0
                    ? Lottie.asset(ZImages.bmiAnimation)
                    : RadicalMeter(
                        bmiMessage:
                            BmiCalculator.getBmiMessage(controller.bmi.value),
                        bmi: controller.bmi.value),
              ),
              Text(
                ZText.bmiScreenHeading,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwInputFields,
              ),
              Form(
                key: controller.bmiKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Weight (In KG's)",
                        prefixIcon: Icon(
                          Iconsax.health,
                          color: ZColor.primary,
                        ),
                      ),
                      controller: controller.weight,
                      validator: controller.weightValidator.call,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: ZSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.align_vertically,
                                color: ZColor.primary,
                              ),
                              labelText: "Height (In Feets)",
                            ),
                            controller: controller.heightInFeet,
                            validator: controller.heightInFeetValidator,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          width: ZSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.direct_right,
                                color: ZColor.primary,
                              ),
                              labelText: "In Inches",
                            ),
                            controller: controller.heightInInches,
                            validator: controller.heightInInchsValidator,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: ZSizes.spaceBtwSections * 2.2,
              // ),
              // SizedBox(
              //   width: Get.width,
              //   child: ElevatedButton(
              //     onPressed: () => controller.calculateBMI(),
              //     child: const Text(
              //       "Calculate",
              //     ),
              //   ),
              // ),
              // if (controller.showDietPlan.value == true) ...[
              //   const SizedBox(
              //     height: ZSizes.spaceBtwInputFields,
              //   ),
              //   SizedBox(
              //     width: Get.width,
              //     child: OutlinedButton(
              //       onPressed: dietplan.generateDietPlan,
              //       child: const Text(
              //         "Generate Diet Plan",
              //       ),
              //     ),
              //   ),
              // ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ZSizes.defaultSpace),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () => controller.calculateBMI(),
                  child: const Text(
                    "Calculate",
                  ),
                ),
              ),
              if (controller.showDietPlan.value == true) ...[
                const SizedBox(
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
              ]
            ],
          ),
        ),
      ),
    );
  }
}
