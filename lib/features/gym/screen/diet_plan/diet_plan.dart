import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/gym/controller/diet_plan/diet_plan_controller.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/widgets/diet_plan_tile.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/widgets/radical_chart.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dietplanController = DietPlanController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: ZSizes.defaultSpace,
            ),
            // Todo: Circular Chart
            Obx(() {
              final calories = dietplanController.dietPlan.value.calories;
              return RadicalChart(
                  carbs: (calories! * 50 / 100),
                  fat: (calories! * 20 / 100),
                  protiens: (calories! * 30 / 100),
                  calories: calories ?? 0);
            }),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: ZSizes.md),
                child: Obx(
                  () => Column(
                    children: [
                      // Todo: Consumed Food
                      if (dietplanController.dietTaken.isNotEmpty) ...[
                        const ZSectionHeading(
                          title: "Consumed Food",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: ZSizes.sm,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dietplanController.dietTaken.length,
                          itemBuilder: (context, index) {
                            final dietTaken =
                                dietplanController.dietTaken[index];
                            return DietPlanTile(
                              image: dietTaken.imageUrl,
                              textTitle: dietTaken.name,
                              protein: dietTaken.protein.toString(),
                              fat: dietTaken.fat.toString(),
                              carbs: dietTaken.carbs.toString(),
                              isSelected: true,
                              onTap: () {
                                ZLogger.info('Diet Taken $dietTaken');
                                dietplanController.selectDiet(dietTaken);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                      ],

                      // Todo: Break Fast
                      if (dietplanController.dietPlan.value.breakfast !=
                          null) ...[
                        const ZSectionHeading(
                          title: "BreakFast",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: ZSizes.sm,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dietplanController
                              .dietPlan.value.breakfast!.length,
                          itemBuilder: (context, index) {
                            final breakfastItem = dietplanController
                                .dietPlan.value.breakfast![index];
                            return DietPlanTile(
                              image: breakfastItem.imageUrl,
                              textTitle: breakfastItem.name,
                              protein: breakfastItem.protein.toString(),
                              fat: breakfastItem.fat.toString(),
                              carbs: breakfastItem.carbs.toString(),
                              onTap: () {
                                ZLogger.info('Diet Taken $breakfastItem');
                                dietplanController.selectDiet(breakfastItem);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: ZSizes.spaceBtwSections,
                        ),
                      ],

                      // Todo: Lunch
                      if (dietplanController.dietPlan.value.lunch != null) ...[
                        const ZSectionHeading(
                          title: "Lunch",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: ZSizes.sm,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              dietplanController.dietPlan.value.lunch!.length,
                          itemBuilder: (context, index) {
                            final breakfastItem =
                                dietplanController.dietPlan.value.lunch![index];
                            return DietPlanTile(
                              image: breakfastItem.imageUrl,
                              textTitle: breakfastItem.name,
                              protein: breakfastItem.protein.toString(),
                              fat: breakfastItem.fat.toString(),
                              carbs: breakfastItem.carbs.toString(),
                              onTap: () {
                                ZLogger.info('Diet Taken $breakfastItem');
                                dietplanController.selectDiet(breakfastItem);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: ZSizes.spaceBtwSections,
                        ),
                      ],

                      // Todo: Snacks
                      if (dietplanController.dietPlan.value.snacks != null) ...[
                        const ZSectionHeading(
                          title: "Snacks",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: ZSizes.sm,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              dietplanController.dietPlan.value.snacks!.length,
                          itemBuilder: (context, index) {
                            final breakfastItem = dietplanController
                                .dietPlan.value.snacks![index];
                            return DietPlanTile(
                              image: breakfastItem.imageUrl,
                              textTitle: breakfastItem.name,
                              protein: breakfastItem.protein.toString(),
                              fat: breakfastItem.fat.toString(),
                              carbs: breakfastItem.carbs.toString(),
                              onTap: () {
                                ZLogger.info('Diet Taken $breakfastItem');
                                dietplanController.selectDiet(breakfastItem);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: ZSizes.spaceBtwSections,
                        ),
                      ],

                      // Todo: Dinner
                      if (dietplanController.dietPlan.value.dinner != null) ...[
                        const ZSectionHeading(
                          title: "Dinner",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: ZSizes.sm,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.all(0),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: ZSizes.sm,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              dietplanController.dietPlan.value.dinner!.length,
                          itemBuilder: (context, index) {
                            final breakfastItem = dietplanController
                                .dietPlan.value.dinner![index];
                            return DietPlanTile(
                              image: breakfastItem.imageUrl,
                              textTitle: breakfastItem.name,
                              protein: breakfastItem.protein.toString(),
                              fat: breakfastItem.fat.toString(),
                              carbs: breakfastItem.carbs.toString(),
                              onTap: () {
                                ZLogger.info('Diet Taken $breakfastItem');
                                dietplanController.selectDiet(breakfastItem);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: ZSizes.spaceBtwSections,
                        )
                      ],
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
