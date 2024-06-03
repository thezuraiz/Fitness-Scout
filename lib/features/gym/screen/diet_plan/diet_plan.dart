import 'package:fitness_scout/common/widgets/section_heading.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/widgets/diet_plan_tile.dart';
import 'package:fitness_scout/features/gym/screen/diet_plan/widgets/radical_chart.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DietPlan extends StatelessWidget {
  const DietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ZSizes.defaultSpace,
            ),
            // Todo: Circular Chart
            RadicalChart(
              carbs: 20,
              fat: 30,
              protiens: 50,
            ),

            // TOdo: Current Food
            Padding(
                padding: EdgeInsets.symmetric(horizontal: ZSizes.defaultSpace),
                child: Column(
                  children: [
                    ZSectionHeading(
                      title: "Current Food",
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                    DietPlanTile(
                      image: ZImages.foodSandwich,
                      textTitle: 'Egg And Fresh Food',
                      protein: '250',
                      fat: '20',
                      carbs: '450',
                    ),
                    SizedBox(
                      height: ZSizes.spaceBtwSections,
                    ),
                    ZSectionHeading(
                      title: "Suitable Food",
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                    DietPlanTile(
                      image: ZImages.peanutSalad,
                      textTitle: 'Peanut Salad',
                      protein: '250',
                      fat: '20',
                      carbs: '450',
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                    DietPlanTile(
                      image: ZImages.potatoFries,
                      textTitle: 'Potato Fries',
                      protein: '250',
                      fat: '20',
                      carbs: '450',
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                    DietPlanTile(
                      image: ZImages.peanutSalad,
                      textTitle: 'Peanut Salad',
                      protein: '250',
                      fat: '20',
                      carbs: '450',
                    ),
                    SizedBox(
                      height: ZSizes.sm,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
