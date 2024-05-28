import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/features/personalization/controller/package_detail_controller.dart';
import 'package:fitness_scout/features/personalization/screen/packages/widgets/package_box.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LandingPackageScreen extends StatelessWidget {
  const LandingPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PackageDetailController();
    return Scaffold(
      appBar: ZCustomAppBar(
        showArrows: true,
        title: Text(
          "GYM Plans",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPackageContainer(
              packageName: 'Basic',
              packagePrice: '2,000',
              backgroundColor: Colors.deepPurple,
              arrowButton: ZColor.primary,
              onPressed: () => controller.basicPlan(),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections * 1.5,
            ),
            CustomPackageContainer(
              packageName: 'Silver',
              packagePrice: '4,000',
              backgroundColor: Colors.pink.withOpacity(0.9),
              arrowButton: ZColor.primary,
              onPressed: () => controller.silverPlan(),
            ),
            const SizedBox(
              height: ZSizes.spaceBtwSections * 1.5,
            ),
            CustomPackageContainer(
              packageName: 'Diamond',
              packagePrice: '8,000',
              backgroundColor: ZColor.primary.withOpacity(0.85),
              arrowButton: Colors.deepPurple,
              onPressed: () => controller.premiumPlan(),
            ),
          ],
        ),
      ),
    );
  }
}
