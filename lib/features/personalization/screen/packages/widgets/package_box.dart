import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomPackageContainer extends StatelessWidget {
  const CustomPackageContainer({
    super.key, required this.packageName, required this.packagePrice, required this.backgroundColor,required this.arrowButton, this.onPressed  });

  final String packageName,packagePrice;
  final Color backgroundColor, arrowButton;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: 330,
        child: Stack(
          children: [
            Container(
              height: 120,
              width: 300,
              padding: const EdgeInsets.all(ZSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    packageName,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: ZColor.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rs/- $packagePrice',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: ZColor.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Per Month',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: ZColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 37,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: arrowButton,
                ),
                child: const Center(
                  child: Icon(
                    Iconsax.arrow_right_3,
                    color: ZColor.white,
                    size: ZSizes.lg * 1.2,
                  ),
                ),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}