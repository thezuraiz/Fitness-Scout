import 'package:fitness_scout/common/widgets/custom_appbar.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class PackageDetailPage extends StatelessWidget {
  const PackageDetailPage(
      {super.key,
      required this.title,
      required this.price,
      required this.description, required this.illustration});

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
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showArrows: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: ZSizes.spaceBtwSections,
              ),
              Image(image: AssetImage(illustration),width: Get.width * 0.7,),
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
        child: ElevatedButton(onPressed: (){},child: Text("Pay Now $price"),),
      ),
    );
  }
}
