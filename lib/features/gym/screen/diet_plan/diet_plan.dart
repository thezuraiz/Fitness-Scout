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
                  carbs: calories! * 50 / 100,
                  fat: calories * 20 / 100,
                  protiens: calories * 30 / 100,
                  calories: calories);
            }),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ZSizes.md),
              child: Column(
                children: [
                  // Todo: Consumed Food
                  Obx(() {
                    if (dietplanController.dietTaken.isNotEmpty) {
                      return Column(children: [
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
                          height: ZSizes.spaceBtwSections,
                        ),
                      ]);
                    } else {
                      return const SizedBox();
                    }
                  }),

                  // Todo: Break Fast
                  Obx(() {
                    final breakfast =
                        dietplanController.dietPlan.value.breakfast;
                    if (breakfast != null &&
                        !breakfast.any((item) =>
                            dietplanController.dietTaken.contains(item))) {
                      return Column(
                        children: [
                          const ZSectionHeading(
                            title: "BreakFast",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: ZSizes.sm,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: ZSizes.sm,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: breakfast.length,
                            itemBuilder: (context, index) {
                              final breakfastItem = breakfast[index];
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
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),

                  // Todo: Lunch
                  Obx(() {
                    final lunch = dietplanController.dietPlan.value.lunch;
                    if (lunch != null &&
                        !lunch.any((item) =>
                            dietplanController.dietTaken.contains(item))) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ZSectionHeading(
                            title: "Lunch",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: ZSizes.sm,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: ZSizes.sm,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lunch.length,
                            itemBuilder: (context, index) {
                              final lunchItem = lunch[index];
                              return DietPlanTile(
                                image: lunchItem.imageUrl,
                                textTitle: lunchItem.name,
                                protein: lunchItem.protein.toString(),
                                fat: lunchItem.fat.toString(),
                                carbs: lunchItem.carbs.toString(),
                                onTap: () {
                                  ZLogger.info('Diet Taken $lunchItem');
                                  dietplanController.selectDiet(lunchItem);
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: ZSizes.spaceBtwSections,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox(); // Return an empty widget if the condition is not met.
                    }
                  }),

                  // Todo: Snacks
                  Obx(() {
                    final snacks = dietplanController.dietPlan.value.snacks;
                    if (snacks != null &&
                        !snacks.any((item) =>
                            dietplanController.dietTaken.contains(item))) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ZSectionHeading(
                            title: "Snacks",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: ZSizes.sm,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: ZSizes.sm,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snacks.length,
                            itemBuilder: (context, index) {
                              return DietPlanTile(
                                image: snacks[index].imageUrl,
                                textTitle: snacks[index].name,
                                protein: snacks[index].protein.toString(),
                                fat: snacks[index].fat.toString(),
                                carbs: snacks[index].carbs.toString(),
                                onTap: () {
                                  ZLogger.info(
                                      'Diet Taken ${snacks[index].name}');
                                  dietplanController.selectDiet(snacks[index]);
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: ZSizes.spaceBtwSections,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox(); // Return an empty widget if the condition is not met.
                    }
                  }),

                  // Todo: Dinner
                  Obx(
                    () {
                      final dinner = dietplanController.dietPlan.value.dinner;
                      if (dinner != null &&
                          !dinner.any((item) =>
                              dietplanController.dietTaken.contains(item))) {
                        return Column(children: [
                          const ZSectionHeading(
                            title: "Dinner",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: ZSizes.sm,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: ZSizes.sm,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dinner.length,
                            itemBuilder: (context, index) {
                              final breakfastItem = dinner[index];
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
                        ]);
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
