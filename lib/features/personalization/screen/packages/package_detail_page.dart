import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/features/authentication/screen/subscription/subscription.dart';
import 'package:fitness_scout/features/personalization/controller/stripe_controller/stripe_service.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PackageDetailPage extends StatelessWidget {
  const PackageDetailPage(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.illustration});

  final String title;
  final String price;
  final String illustration;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZCustomAppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showArrows: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Lottie.asset(illustration),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  // Adjust padding as needed
                  child: Markdown(
                    data: description,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ZSizes.sm),
        child: ElevatedButton(
          onPressed: () => {
            // Get.off(SubscriptionScreen(
            // toPay: price,
            // );
            StripeService.instance.makePayment()
          },
          child: Text("Pay Now $price"),
        ),
      ),
    );
  }
}
