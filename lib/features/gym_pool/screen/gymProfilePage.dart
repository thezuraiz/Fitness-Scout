import 'package:fitness_scout/features/gym_pool/screen/gymScanner.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/sizes.dart';
import '../model/gym_model.dart';

class GymDetailScreen extends StatelessWidget {
  final GymOwnerModel gym;

  const GymDetailScreen({Key? key, required this.gym}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240, // Increased height to accommodate CircleAvatar
                width: double.infinity,
                child: Image.network(
                  gym.images?.isNotEmpty == true
                      ? gym.images![0]
                      : 'https://via.placeholder.com/200',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${gym.gymName ?? "Gym Name"} GYM',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.star5,
                              color: Colors.amber,
                              size: 24,
                            ),
                            const SizedBox(
                              width: ZSizes.spaceBtwItems / 2,
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: '5.0',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              TextSpan(text: '(${gym.visitors!.length})')
                            ])),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ReadMoreText(
                      gym.description.toString() * 50 ??
                          "No description provided.",
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "Show More",
                      trimExpandedText: "Show Less",
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      lessStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: ZSizes.sm),
                    Divider(),
                    const SizedBox(height: ZSizes.sm),
                    buildSectionTitle(context, 'Contact Info'),
                    buildContactRow(
                      context,
                      gym.contactNumber ?? 'Not Provided',
                      Iconsax.call,
                    ),
                    const SizedBox(height: 10),
                    buildSectionTitle(context, 'Address'),
                    buildContactRow(
                      context,
                      gym.address ?? 'Not Provided',
                      Iconsax.location,
                    ),
                    const SizedBox(height: 10),
                    buildSectionTitle(context, 'Email'),
                    buildContactRow(
                      context,
                      gym.email,
                      Icons.email_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.to(GymScanner(
                    gymId: gym.id,
                    gymName: gym.gymName.toString(),
                  )),
              child: const Text('Check In')),
        ),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget buildContactRow(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: ZColor.primary,
          size: ZSizes.iconMd,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ZLoaders.successSnackBar(
                title: 'Copied to clipboard', message: text.toString());
          },
          icon: Icon(
            Iconsax.copy,
            color: Colors.grey[600],
            size: ZSizes.iconMd,
          ),
        ),
      ],
    );
  }
}
