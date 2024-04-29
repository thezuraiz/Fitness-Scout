import 'package:fitness_scout/common/styles/AppbarPadding.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/constants/text_strings.dart';
import 'package:fitness_scout/utils/device/deviceUtilities.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image,title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding * 2,
          child: Column(
            children: [
              // --- TODO: Image
              Image.asset(
                image,
                width: ZDeviceUtils.getScreenWidth() * 0.6,
              ),

              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              // --- TODO: Title & Subtitle
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 23),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // --- TODO: Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(ZText.Continue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
